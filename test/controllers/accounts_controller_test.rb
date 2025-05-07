require 'test_helper'

class AccountsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  test 'only an account_manager can edit an account' do
    get edit_account_path
    assert_redirected_to new_agent_session_path

    sign_in agents(:agent)
    get edit_account_path
    assert_redirected_to agent_root_path
    sign_out :agent

    sign_in agents(:admin)
    get edit_account_path
    assert_redirected_to agent_root_path
    sign_out :agent

    sign_in agents(:account_manager)
    get edit_account_path
    assert_response :success
    assert_select 'h1', 'Agency settings'
    sign_out :agent
  end

  test 'only an account_manager can update an account' do
    params = {
      account: {
        company_name: 'updated company_name',
        legal_name: 'updated legal_name',
        domain_name: 'updated domain_name',
        phone: 'updated phone',
        email: 'updated email',
        fax: 'updated fax'
      }
    }

    patch account_path, params: params
    assert_redirected_to new_agent_session_path

    sign_in agents(:agent)
    patch account_path, params: params
    assert_redirected_to agent_root_path
    sign_out :agent

    sign_in agents(:admin)
    patch account_path, params: params
    assert_redirected_to agent_root_path
    sign_out :agent

    sign_in agents(:account_manager)
    patch account_path, params: params
    assert_redirected_to edit_account_path
    follow_redirect!
    assert_select 'h1', 'Agency settings'
    sign_out :agent

    account = accounts(:one)
    assert_equal 'updated company_name', account.company_name
    assert_equal 'updated legal_name', account.legal_name
    assert_equal 'updated domain_name', account.domain_name
    assert_equal 'updated phone', account.phone
    assert_equal 'updated email', account.email
    assert_equal 'updated fax', account.fax
  end
end
