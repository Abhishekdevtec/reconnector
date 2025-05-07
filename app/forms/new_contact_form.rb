# frozen_string_literal: true

class NewContactForm
  include ActiveModel::Model
  include ActiveModel::Attributes

  delegate :id, :persisted?, :model_name, :to_param, :notes, to: :@contact, allow_nil: true

  # Contact attributes
  attribute :account_id,                     :big_integer
  attribute :agent_id,                       :big_integer
  attribute :type,                           :string
  attribute :share,                          :boolean
  attribute :first_name,                     :string
  attribute :last_name,                      :string
  attribute :business_name,                  :string
  attribute :legal_name,                     :string
  attribute :job_title,                      :string
  attribute :email,                          :string
  attribute :phone,                          :string
  attribute :mobile,                         :string
  attribute :fax,                            :string
  attribute :url,                            :string
  attribute :registration,                   :string
  attribute :notes,                          :string
  attribute :synchronize_with_office_online, :boolean

  # Contact Classifiers
  attr_accessor :classifications # An array

  # First Address which we are going
  # to manage as nested attributes within
  # the form:
  # [first_address][line_1], [first_address][line_2], etc.
  attribute :first_address_category,    :integer, default: nil
  attribute :first_address_line_1,      :string,  default: nil
  attribute :first_address_line_2,      :string,  default: nil
  attribute :first_address_line_3,      :string,  default: nil
  attribute :first_address_city,        :string,  default: nil
  attribute :first_address_postal_code, :string,  default: nil
  attribute :first_address_state,       :string,  default: nil
  attribute :first_address_country,     :string,  default: nil

  # Second Address which we are going
  # to manage as nested attributes within
  # the form:
  # [second_address][line_1], [second_address][line_2], etc.
  attribute :second_address_category,    :integer, default: nil
  attribute :second_address_line_1,      :string,  default: nil
  attribute :second_address_line_2,      :string,  default: nil
  attribute :second_address_line_3,      :string,  default: nil
  attribute :second_address_city,        :string,  default: nil
  attribute :second_address_postal_code, :string,  default: nil
  attribute :second_address_state,       :string,  default: nil
  attribute :second_address_country,     :string,  default: nil

  # class attributes
  attr_accessor :params, :contact

  def initialize(params = {})
    @params = transformed_params(params)
    @contact = create_new_record
    @classifications = params[:classifications] if @params
    super @params
  end

  def save
    return false if invalid?

    ActiveRecord::Base.transaction do
      save_contact
      save_classifications
      save_first_address
      save_second_address
      true
    end
  rescue ActiveRecord::RecordInvalid
    Rails.logger.info 'ActiveRecord::RecordInvalid thrown with params'
    Rails.logger.info extract_contact_params
    Rails.logger.info @contact.errors.inspect
    false
  end

  private

  # Since we are dealing with nested params
  # in the form, we need to transpose those
  # into our class attributes
  def transformed_params(params)
    tp = params.slice(*attribute_keys)

    [:first_address, :second_address].each do |sub_params|
      if params[sub_params]
        params[sub_params].each do |key, value|
          sub_value = {}
          sub_value["#{sub_params}_#{key}"] = value
          tp.merge! sub_value
        end
      end
    end
    tp.permit(tp.keys)
  end

  def create_new_record
    account.contacts.new(extract_contact_params)
  end

  # Returns an array of the class attributes
  # as keys
  def attribute_keys
    contact_keys
      .push(*address_keys('first_address_'))
      .push(*address_keys('second_address_'))
  end

  def contact_keys
    Contact.new.attributes.keys.collect(&:to_sym)
  end

  def address_keys(prefix = nil)
    Address.new.attributes.keys.collect { |a| "#{prefix}#{a}".to_sym }
  end

  def account
    @account ||= Account.find(@params[:account_id])
  end

  def save_contact
    @contact = account.contacts.create(extract_contact_params)
    add_errors(@contact.errors) if @contact.invalid?
    @contact.save!
  end

  def save_classifications
    return unless classifications&.any?

    # Create selected classifications
    classifications.each do |classification|
      @contact.classifications.create!(account: account, name: classification)
    end
  end

  def save_first_address
    return if all_first_address_params_missing?

    record = @contact.addresses.create(first_address_params)
    add_errors(record.errors) if record.invalid?
    record.save!
  end

  def save_second_address
    return if all_second_address_params_missing?

    record = @contact.addresses.create(second_address_params)
    add_errors(record.errors) if record.invalid?
    record.save!
  end

  # From params, return only the params
  # that apply to a Contact model
  def extract_contact_params
    @params.slice(*contact_attributes)
  end

  def contact_attributes
    %i[account_id agent_id type share first_name last_name business_name legal_name job_title email phone mobile fax url registration notes synchronize_with_office_online]
  end

  def all_first_address_params_missing?
    [
      first_address_line_1, first_address_line_2,
      first_address_line_3, first_address_city,
      first_address_postal_code, first_address_state,
      first_address_country
    ].all? { |a| a.nil? || a.empty? }
  end

  def all_second_address_params_missing?
    [
      second_address_line_1, second_address_line_2,
      second_address_line_3, second_address_city,
      second_address_postal_code, second_address_state,
      second_address_country
    ].all? { |a| a.nil? || a.empty? }
  end

  def first_address_params
    {
      category: first_address_category,
      line_1: first_address_line_1,
      line_2: first_address_line_2,
      line_3: first_address_line_3,
      city: first_address_city,
      postal_code: first_address_postal_code,
      state: first_address_state,
      country: first_address_country
    }
  end

  def second_address_params
    {
      category: second_address_category,
      line_1: second_address_line_1,
      line_2: second_address_line_2,
      line_3: second_address_line_3,
      city: second_address_city,
      postal_code: second_address_postal_code,
      state: second_address_state,
      country: second_address_country
    }
  end

  def add_errors(model_errors)
    model_errors.each { |error| errors.add(error.attribute, error.message) }
  end
end
