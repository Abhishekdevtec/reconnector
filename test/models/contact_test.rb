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
require 'test_helper'

class ContactTest < ActiveSupport::TestCase
  test 'should be unshared by default' do
    contact = Contact.new
    assert_not contact.share
    assert_not contact.shared?
  end

  context 'validations' do
    should belong_to :account
  end

  test 'account ids are always coherent' do
    agent = agents(:bill)
    a_different_account = Account.create!(company_name: 'company', legal_name: 'legal name', domain_name: 'domain.com')

    assert_raise('ActiveRecord::RecordInvalid') { agent.businesses.create!(business_name: 'JLC', account: a_different_account) }
    assert_raise('ActiveRecord::RecordInvalid') { agent.individuals.create!(name: 'John Locke', account: a_different_account) }
  end
end
