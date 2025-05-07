class EditBusinessForm
  include ActiveModel::Model
  include ActiveModel::Attributes

  delegate :id, :persisted?, :model_name, :to_param, :notes, to: :@record, allow_nil: true

  # Contact attributes
  attribute :account_id,      :big_integer
  attribute :agent_id,        :big_integer
  attribute :type,            :string
  attribute :share,           :boolean
  attribute :business_name,   :string
  attribute :legal_name,      :string
  attribute :email,           :string
  attribute :phone,           :string
  attribute :mobile,          :string
  attribute :fax,             :string
  attribute :url,             :string
  attribute :registration,    :string
  attribute :notes,           :string

  # Classifiers
  attr_accessor :classifications # An array is passed

  # https://blog.frost.tw/en/posts/2020/05/03/Build-a-Form-Helper-capable-Form-Object-in-Rails/
  def initialize(record, update_params = {})
    @record = record
    @update_params = update_params

    if @update_params&.keys&.any?
      @classifications = @update_params[:classifications]
      super extract_business_params(@update_params)
    else
      @classifications = @record&.classifications&.pluck(:name)
      super extract_business_params(@record.attributes)
    end
  end

  def to_model
    @record ||= Business.new
  end

  def update(params = {})
    return false if invalid?

    ActiveRecord::Base.transaction do
      update_contact(extract_business_params(params))
      update_classifications(params)
      true
    end
  rescue ActiveRecord::RecordInvalid
    false
  end

  private

  def extract_business_params(params)
    return {} if params.nil?

    business_params = {}
    business_attributes.each do |key|
      business_params[key.to_sym] = params[key.to_s] unless params[key.to_s]&.nil?
    end
    business_params
  end

  def business_attributes
    %i[account_id agent_id type share business_name legal_name email phone mobile fax url registration notes]
  end

  def update_contact(update_params = {})
    result = @record.update!(update_params)
    add_errors(@record.errors) if @record.invalid?
    result
  end

  # Make sure to raise an exception for transaction purposes
  def update_classifications(update_params = {})
    classifications = update_params[:classifications]

    # TODO: Remove unselected
    if business_has_classifications?
      if classifications
        to_remove = existing_classifications - classifications
        @record.classifications.where(name: to_remove).each(&:destroy)
      else
        @record.classifications.destroy_all
      end
    end

    # Create selected classifications
    if classifications && classifications.any?
      to_add = classifications - existing_classifications
      to_add.each do |classification|
        @record.classifications.create!(account: @record.account, name: classification)
      end
    end
  end

  def existing_classifications
    @record&.classifications&.pluck(:name) || []
  end

  def business_has_classifications?
    existing_classifications.present?
  end

  def add_errors(model_errors)
    model_errors.each { |error| errors.add(error.attribute, error.message) }
  end
end
