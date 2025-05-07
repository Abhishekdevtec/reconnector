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
require "test_helper"

class AccountTest < ActiveSupport::TestCase
  context 'validations' do
    should validate_presence_of(:company_name)
    should validate_presence_of(:legal_name)
    should validate_presence_of(:domain_name)

    should validate_uniqueness_of(:company_name)
    should validate_uniqueness_of(:legal_name)
    should validate_uniqueness_of(:domain_name)

    should validate_length_of(:company_name).is_at_least(2)
    should validate_length_of(:legal_name).is_at_least(2)
    should validate_length_of(:domain_name).is_at_least(2)
  end

  test 'should return an HTTPS url' do
    account = accounts(:one)
    assert account.url.start_with?('https://')
  end

  test 'should normalize the company name' do
    account = Account.new(company_name: '   BigCo International   ')
    assert_equal account.company_name, 'BigCo International'
  end

  test 'should normalize the legal name' do
    account = Account.new(legal_name: '   BigCo Internaltional SAS   ')
    assert_equal account.legal_name, 'BigCo Internaltional SAS'
  end

  test 'should normalize the domain name' do
    account = Account.new(domain_name: '   www.example.com   ')
    assert_equal account.domain_name, 'www.example.com'
  end

  test 'should normalize the email' do
    account = Account.new(email: '   CONTACT@BIGCO.COM   ')
    assert_equal account.email, 'contact@bigco.com'
  end
end
