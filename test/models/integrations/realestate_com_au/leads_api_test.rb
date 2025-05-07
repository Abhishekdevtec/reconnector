require "test_helper"

class LeadsApiConcernTest < ActiveSupport::TestCase
  setup do
    @account = accounts(:one)
  end

  test 'realestate_com_au_leads_api_enabled? should return false without leads_api' do
    assert_equal false, @account.realestate_com_au_leads_api_enabled?
  end

  test 'realestate_com_au_leads_api_enabled? should return enabled state with leads_api' do
    @account.enable_realestate_com_au_leads_api
    assert_equal true, @account.realestate_com_au_leads_api_enabled?
  end

  test 'realestate_com_au_leads_api_enabled? should return enabled/disabled state with leads_api' do
    @account.enable_realestate_com_au_leads_api
    assert_equal true, @account.realestate_com_au_leads_api_enabled?

    @account.disable_realestate_com_au_leads_api
    assert_equal false, @account.realestate_com_au_leads_api_enabled?

    @account.enable_realestate_com_au_leads_api
    assert_equal true, @account.realestate_com_au_leads_api_enabled?
  end
end

# == Schema Information
#
# Table name: integrations_realestate_com_au_leads_apis
#
#  account_id          :bigint           not null
#  created_at          :datetime         not null
#  enabled             :boolean
#  id                  :bigint           not null, primary key
#  last_request_status :string
#  last_requested_at   :datetime
#  updated_at          :datetime         not null
#
# Indexes
#
#  index_integrations_realestate_com_au_leads_apis_on_account_id  (account_id)
#
