# frozen_string_literal: true
#
# Form to create an account with
# a primary agent and 2 addresses
# to get started
class CreateAccountForm
  include ActiveModel::Model
  include ActiveModel::Attributes

  # Account attributes
  attribute :company_name, :string, default: nil
  attribute :legal_name,   :string, default: nil
  attribute :domain_name,  :string, default: nil

  # primary Agent attributes
  attribute :agent_first_name, :string, default: nil
  attribute :agent_last_name,  :string, default: nil
  attribute :agent_email,      :string, default: nil
  attribute :agent_password,   :string, default: nil

  # first Address attributes
  attribute :first_address_category,    :integer, default: nil
  attribute :first_address_line_1,      :string,  default: nil
  attribute :first_address_line_2,      :string,  default: nil
  attribute :first_address_line_3,      :string,  default: nil
  attribute :first_address_city,        :string,  default: nil
  attribute :first_address_postal_code, :string,  default: nil
  attribute :first_address_state,       :string,  default: nil
  attribute :first_address_country,     :string,  default: nil

  # second Address attributes
  attribute :second_address_category,    :integer, default: nil
  attribute :second_address_line_1,      :string,  default: nil
  attribute :second_address_line_2,      :string,  default: nil
  attribute :second_address_line_3,      :string,  default: nil
  attribute :second_address_city,        :string,  default: nil
  attribute :second_address_postal_code, :string,  default: nil
  attribute :second_address_state,       :string,  default: nil
  attribute :second_address_country,     :string,  default: nil

  # class attributes
  attr_accessor :params, :account

  delegate :id, :persisted?, :model_name, :to_param, to: :@account, allow_nil: true

  def initialize(params = {})
    @account = Account.new
    @params = params
    super params
  end

  def self.permitted_params(params)
    params
      .require(:account)
      .permit(CreateAccountForm.permitted_keys)
  end

  # Returns an array of attributes
  # defined in this Form object
  def self.permitted_keys
    CreateAccountForm.new.attributes.keys.collect(&:to_sym)
  end

  def save
    return false if invalid?

    ActiveRecord::Base.transaction do
      save_account
      save_agent
      save_first_address
      save_second_address
      true
    end
  rescue ActiveRecord::RecordInvalid
    false
  end

  private

  def save_account
    @account = Account.create(account_params)
    add_errors(@account.errors) if @account.invalid?
    @account.save!
  end

  # We don't want to create an Agent if
  # none of the attributes are given
  def save_agent
    return if all_agent_params_missing?

    record = @account.agents.create(agent_params)
    add_errors(record.errors) if record.invalid?
    record.save!
  end

  def save_first_address
    return if all_first_address_params_missing?

    record = @account.addresses.create(first_address_params)
    add_errors(record.errors) if record.invalid?
    record.save!
  end

  def save_second_address
    return if all_second_address_params_missing?

    record = @account.addresses.create(second_address_params)
    add_errors(record.errors) if record.invalid?
    record.save!
  end

  def account_params
    { company_name: company_name, legal_name: legal_name, domain_name: domain_name }
  end

  def agent_params
    { first_name: agent_first_name, last_name: agent_last_name, email: agent_email, password: agent_password }
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

  def all_agent_params_missing?
    [agent_first_name, agent_last_name, agent_email, agent_password].all? { |a| a.nil? || a.empty? }
  end

  def all_first_address_params_missing?
    [
      first_address_category, first_address_line_1,
      first_address_line_2, first_address_line_3,
      first_address_city, first_address_postal_code,
      first_address_state, first_address_country
    ].all? { |a| a.nil? || a.empty? }
  end

  def all_second_address_params_missing?
    [
      second_address_category, second_address_line_1,
      second_address_line_2, second_address_line_3,
      second_address_city, second_address_postal_code,
      second_address_state, second_address_country
    ].all? { |a| a.nil? || a.empty? }
  end
end
