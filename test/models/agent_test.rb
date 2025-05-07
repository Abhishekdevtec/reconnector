# == Schema Information
#
# Table name: agents
#
#  account_id             :bigint           not null
#  created_at             :datetime         not null
#  current_country        :string
#  current_sign_in_at     :datetime
#  current_sign_in_ip     :string
#  current_state          :string
#  domain_com_au_agent_id :string
#  email                  :string           default(""), not null
#  encrypted_ews_password :string
#  encrypted_password     :string           default(""), not null
#  ews_username           :string
#  fax                    :string
#  first_name             :string
#  id                     :bigint           not null, primary key
#  last_name              :string
#  last_sign_in_at        :datetime
#  last_sign_in_ip        :string
#  mobile                 :string
#  phone                  :string
#  rea_agent_id           :string
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  role                   :integer          default("agent")
#  sign_in_count          :integer          default(0), not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_agents_on_account_id            (account_id)
#  index_agents_on_email                 (email) UNIQUE
#  index_agents_on_reset_password_token  (reset_password_token) UNIQUE
#
require "test_helper"

class AgentTest < ActiveSupport::TestCase
  context 'validations' do
    should validate_presence_of(:first_name)
    should validate_presence_of(:last_name)
    should validate_presence_of(:email)
    should belong_to :account
  end

  test 'should see shared contacts' do
    @account = accounts(:one)
    @agent_who_shares = agents(:bill)
    @agent_who_shares.update(account_id: @account.id)
    @agent = agents(:steve)
    @agent.update(account_id: @account.id)

    # Clear all contacts
    @account.contacts.update_all(share: false)
    @agent.contacts.destroy_all
    assert_equal 0, @agent.visible_contacts.length

    # Share Contacts and test
    assert @agent_who_shares.contacts.length > 1
    @agent_who_shares.contacts.update_all(share: true)
    assert_equal @agent_who_shares.contacts.length, @agent.visible_contacts.length
  end

  test "should only see shared contacts from same account" do
    @account = accounts(:one)
    @agent_who_shares = agents(:bill)
    @agent = agents(:steve)
    assert_not_equal @agent_who_shares.account_id, @agent.account_id

    # Clear all contacts
    @account.contacts.update_all(share: false)
    @agent.contacts.destroy_all
    assert_equal 0, @agent.visible_contacts.length

    # Share Contacts and test
    assert @agent_who_shares.contacts.length > 1
    @agent_who_shares.contacts.update_all(share: true)
    assert_equal 0, @agent.visible_contacts.length
  end

  test 'different agent roles' do
    agent = agents(:agent)
    assert agent.agent?

    agent = agents(:account_manager)
    assert agent.account_manager?

    agent = agents(:admin)
    assert agent.admin?
  end
end
