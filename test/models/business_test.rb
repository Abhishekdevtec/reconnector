# == Schema Information
#
# Table name: contacts
#
#  account_id                     :bigint           not null
#  agent_id                       :bigint           not null
#  business_id                    :bigint
#  business_name                  :string
#  classifiable_id                :bigint
#  classifiable_type              :string
#  created_at                     :datetime         not null
#  email                          :string
#  ews_change_key                 :string
#  ews_created_at                 :datetime
#  ews_imported_from_ews          :boolean          default(FALSE)
#  ews_item_id                    :string
#  ews_last_modified_at           :datetime
#  ews_received_at                :datetime
#  ews_sent_at                    :datetime
#  fax                            :string
#  first_name                     :string
#  id                             :bigint           not null, primary key
#  job_title                      :string
#  last_name                      :string
#  legal_name                     :string
#  mobile                         :string
#  notes                          :text
#  phone                          :string
#  registration                   :string
#  share                          :boolean          default(FALSE)
#  skype                          :string
#  source_id                      :string
#  synchronize_with_office_online :boolean          default(FALSE)
#  type                           :string
#  updated_at                     :datetime         not null
#  url                            :string
#
# Indexes
#
#  index_contacts_on_account_id    (account_id)
#  index_contacts_on_agent_id      (agent_id)
#  index_contacts_on_business_id   (business_id)
#  index_contacts_on_classifiable  (classifiable_type,classifiable_id)
#
require "test_helper"

class BusinessTest < ActiveSupport::TestCase
  context 'validations' do
    should belong_to :account
  end

  # Businesses should have an account, an agent
  # and have at lease one of the following fields
  # present:
  # business_name, legal_name, email, or phone
  test 'should validate business with minimum fields' do
    account = accounts(:one)
    agent = account.agents.last

    business = account.businesses.new(agent: agent)
    assert business.invalid?

    business = account.businesses.new(agent: agent, business_name: 'BigCo')
    assert business.valid?

    business = account.businesses.new(agent: agent, legal_name: 'BigCo LLC')
    assert business.valid?

    business = account.businesses.new(agent: agent, email: 'hello@bigco.com')
    assert business.valid?

    business = account.businesses.new(agent: agent, phone: '0123456789')
    assert business.valid?
  end
end
