class UpdateContactForm
  include ActiveModel::Model
  include ActiveModel::Attributes

  delegate :id, :persisted?, :model_name, :to_param, to: :@record, allow_nil: true

  # Contact attributes
  attribute :account_id,      :big_integer
  attribute :agent_id,        :big_integer
  attribute :type,            :string
  attribute :share,           :boolean
  attribute :first_name,      :string
  attribute :last_name,       :string
  attribute :business_name,   :string
  attribute :legal_name,      :string
  attribute :job_title,       :string
  attribute :email,           :string
  attribute :phone,           :string
  attribute :mobile,          :string
  attribute :fax,             :string
  attribute :url,             :string
  attribute :registration,    :string
  attribute :notes,           :string

  # Classifiers
  attr_accessor :classifications # An array is passed

  # Validations
  # validate do |record|
  #   MinimumBusinessRequiredFields.new(record).validate
  # end

  # https://blog.frost.tw/en/posts/2020/05/03/Build-a-Form-Helper-capable-Form-Object-in-Rails/
  def initialize(params = {})
    @params = params
    @record = @params[:contact]
    @classifications = params[:classifications] if @params
    super extract_contact_params
  end

  def to_model
    @record ||= Contact.new
  end

  def update(params = {})
    return false if invalid?

    ActiveRecord::Base.transaction do
      update_contact(extract_contact_params)
      update_classifications(params)
      true
    end
  rescue ActiveRecord::RecordInvalid
    false
  end

  # To be used with
  # <%= form.collection_check_boxes :city_id, City.order(:name), :id, :name %>
  def classification_options
    account.classifiers.select(:name)
  end

  def classifications_attributes=(values)
    @classifications = values.map { |_key, params| Classifications.new(params) }
  end

  private

  def account
    @account ||= Account.find(account_id)
  end

  def update_contact(params = {})
    @params = params
    Rails.logger.info extract_contact_params
    result = @record.update!(extract_contact_params)
    add_errors(@record.errors) if @record.invalid?
    result
  end

  def save_classifications
    return if classifications&.nil?

    # Create selected classifications
    classifications.each do |classification|
      @record.classifications.create!(account: account, name: classification)
    end
  end

  # Make sure to raise an exception for transaction purposes
  def update_classifications(update_params = {})
    # TODO: Remove unselected
    if classifications_might_need_to_be_removed?
      to_remove = existing_classifications - classifications
      @record.classifications.where(name: to_remove).each do |r|
        r.destroy
      end
    end

    # Create selected classifications
    if classifications_modified?
      to_add = classifications - existing_classifications
      to_add.each do |classification|
        @record.classifications.create!(account: @record.account, name: classification)
      end
    end
  end

  def existing_classifications
    @record&.classifications&.pluck(:name) || []
  end

  def classifications_modified?
    classifications.present?
  end

  def business_has_classifications?
    existing_classifications.present?
  end

  def classifications_might_need_to_be_removed?
    classifications_modified? && business_has_classifications?
  end

  def add_errors(model_errors)
    model_errors.each { |error| errors.add(error.attribute, error.message) }
  end

  # From params, return only the params
  # that apply to a Contact model
  def extract_contact_params
    @params.slice(*contact_attributes)
    # return {} if @params.nil?

    # contact_params = {}
    # contact_attributes.each do |key|
    #   contact_params[key.to_sym] = @params[key.to_sym] unless @params[key.to_sym]&.nil?
    # end
    # contact_params
  end

  def contact_attributes
    %i[account_id agent_id type share first_name last_name business_name legal_name job_title email phone mobile fax url registration notes]
  end
end