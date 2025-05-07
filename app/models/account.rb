# frozen_string_literal: true
class Account < ApplicationRecord
  include HasAddresses
  include NormalizeBlankValues
  include AccountSupportForRea
  include AccountSupportForDomainComAu
  include AccountSupportForGriffinProperty
  include AccountSupportForMicrosoftGraph
  include Accounts::DomainComAu::WebhookSubscribeable

  has_many :agents, dependent: :destroy
  has_many :contacts, dependent: :destroy
  has_many :businesses, dependent: :destroy
  has_many :individuals, dependent: :destroy
  has_many :classifications, dependent: :destroy
  has_many :classifiers, dependent: :destroy
  has_many :activity_logs, dependent: :destroy
  has_many :inbound_webhooks, dependent: :destroy
  has_many :listing_enquiries, dependent: :destroy
  has_many :raw_listing_enquiries, dependent: :delete_all

  has_many :properties,             through: :agents
  has_many :commercial_properties,  through: :agents
  has_many :industrial_properties,  through: :agents
  has_many :residential_properties, through: :agents
  has_many :retail_properties,      through: :agents
  has_many :portal_listings,        through: :properties

  has_one_attached :pdf_logo

  include Account::Integrations::RealestateComAu
  include Account::Integrations::RealestateComAu::Client
  include Account::Integrations::RealestateComAu::Leads
  include Account::Integrations::DomainComAu

  validates :company_name, :legal_name, :domain_name, uniqueness: true
  validates :company_name, :legal_name, :domain_name, presence: true
  validates :company_name, :legal_name, :domain_name, length: { minimum: 2 }

  def url
    "https://#{domain_name}"
  end

  def pdf_logo_as_svg
    return nil unless pdf_logo.attached?

    pdf_logo.open do |file|
      file.read.html_safe
    end
  end
end

# == Schema Information
#
# Table name: accounts
#
#  azure_application_id                           :string
#  azure_encrypted_client_secret                  :string
#  azure_tenant_id                                :string
#  brochure_disclaimer                            :string
#  company_name                                   :string
#  created_at                                     :datetime         not null
#  domain_com_au_access_token_expires_at          :datetime
#  domain_com_au_access_token_type                :string
#  domain_com_au_address_suggestions_api_key      :string
#  domain_com_au_agency_id                        :string
#  domain_com_au_agents_and_listings_api_key      :string
#  domain_com_au_client_id                        :string
#  domain_com_au_encrypted_access_token           :string
#  domain_com_au_encrypted_authorization_code     :string
#  domain_com_au_encrypted_client_secret          :string
#  domain_com_au_encrypted_refresh_token          :string
#  domain_com_au_listings_management_api_key      :string
#  domain_com_au_price_estimation_api_key         :string
#  domain_com_au_properties_and_locations_api_key :string
#  domain_com_au_schools_data_api_key             :string
#  domain_com_au_webhooks_api_key                 :string
#  domain_com_au_webhooks_id                      :string
#  domain_com_au_webhooks_verification_code       :string
#  domain_name                                    :string
#  email                                          :string
#  enable_microsoft_graph_support                 :boolean          default(FALSE)
#  encrypted_griffin_property_com_au_api_token    :string
#  ews_endpoint                                   :string
#  ews_synchronize                                :boolean          default(FALSE)
#  fax                                            :string
#  griffin_property_destination_folder            :string
#  griffin_property_encrypted_password            :string
#  griffin_property_host_url                      :string
#  griffin_property_username                      :string
#  id                                             :bigint           not null, primary key
#  legal_name                                     :string
#  phone                                          :string
#  primary_color                                  :string
#  rea_client_id                                  :string
#  rea_encrypted_client_secret                    :string
#  rea_encrypted_password                         :string
#  rea_host                                       :string
#  rea_party_id                                   :string
#  rea_username                                   :string
#  secondary_color                                :string
#  updated_at                                     :datetime         not null
#
