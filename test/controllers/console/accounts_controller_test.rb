require 'test_helper'

module Console
  class AccountsControllerTest < ActionDispatch::IntegrationTest
    include Devise::Test::IntegrationHelpers

    setup do
      @overlord = overlords(:one)
      @account = accounts(:one)
    end

    test 'should get index' do
      get console_accounts_url
      assert_redirected_to new_overlord_session_path

      sign_in @overlord
      get console_accounts_url
      assert_response :success
      sign_out :overlord
    end

    test 'should get new' do
      get new_console_account_url
      assert_redirected_to new_overlord_session_path

      sign_in @overlord
      get new_console_account_url
      assert_response :success
      sign_out :overlord
    end

    test 'should create account' do
      company_name = 'Newco'
      legal_name = 'NewCo TST'
      domain_name = 'newco.com'

      post console_accounts_url, params: { account: { company_name: company_name, domain_name: domain_name, legal_name: legal_name } }
      assert_redirected_to new_overlord_session_path

      sign_in @overlord
      assert_difference('Account.count') do
        post console_accounts_url, params: { account: { company_name: company_name, domain_name: domain_name, legal_name: legal_name } }
      end
      assert_redirected_to console_account_url(Account.last)
      sign_out :overlord
    end

    test 'should show account' do
      company_name = 'Newco'
      legal_name = 'NewCo TST'
      domain_name = 'newco.com'
      @account = Account.create!(company_name: company_name, domain_name: domain_name, legal_name: legal_name)
      get console_account_url(@account)
      assert_redirected_to new_overlord_session_path

      sign_in @overlord
      get console_account_url(@account)
      assert_response :success
      sign_out :overlord
    end

    test 'should get edit' do
      get edit_console_account_url(@account)
      assert_redirected_to new_overlord_session_path

      sign_in @overlord
      get edit_console_account_url(@account)
      assert_response :success
      sign_out :overlord
    end

    test 'should update account' do
      patch console_account_url(@account), params: { account: { company_name: @account.company_name, domain_name: @account.domain_name, legal_name: @account.legal_name } }
      assert_redirected_to new_overlord_session_path

      sign_in @overlord
      patch console_account_url(@account), params: { account: { company_name: @account.company_name, domain_name: @account.domain_name, legal_name: @account.legal_name } }
      assert_redirected_to console_account_url(@account)
      sign_out :overlord
    end

    test 'should destroy account' do
      delete console_account_url(@account)
      assert_redirected_to new_overlord_session_path

      sign_in @overlord
      assert_difference('Account.count', -1) do
        delete console_account_url(@account)
      end
      assert_redirected_to console_accounts_url
      sign_out :overlord
    end
  end
end
