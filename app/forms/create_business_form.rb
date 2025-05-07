class CreateBusinessForm
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
  attr_accessor :classifications # An array

  # Validations
  validate do |record|
    MinimumBusinessRequiredFields.new(record).validate
  end

  # https://blog.frost.tw/en/posts/2020/05/03/Build-a-Form-Helper-capable-Form-Object-in-Rails/
  def initialize(params = {})
    @record = record
    @params = params[:params]
    @classifications = params[:params][:classifications] if params[:params]
    super extract_business_params(params[:params])
  end

  def to_model
    @record ||= Business.new
  end

  def save
    return false if invalid?

    ActiveRecord::Base.transaction do
      save_contact
      save_classifications
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

  def record
    return account.businesses.new if @account

    Business.new
  end

  def save_contact
    @record = account.businesses.create(contact_params)
    add_errors(@record.errors) if @record.invalid?
    @record.save!
  end

  def contact_params
    {
      account_id: account_id,
      agent_id: agent_id,
      business_name: business_name,
      legal_name: legal_name,
      email: email,
      url: url,
      phone: phone,
      fax: fax,
      registration: registration,
      notes: notes,
      share: share
    }
  end

  def save_classifications
    return unless classifications&.any?

    # Create selected classifications
    classifications.each do |classification|
      @record.classifications.create!(account: account, name: classification)
    end
  end

  def add_errors(model_errors)
    model_errors.each { |error| errors.add(error.attribute, error.message) }
  end

  # From params, return only the params
  # that apply to a Business model
  def extract_business_params(params)
    return {} if params.nil?

    business_params = {}
    business_attributes.each do |key|
      business_params[key.to_sym] = params[key.to_sym]
    end
    business_params
  end

  def business_attributes
    %i[account_id agent_id type share first_name last_name business_name legal_name job_title email phone mobile fax url registration notes]
  end
end