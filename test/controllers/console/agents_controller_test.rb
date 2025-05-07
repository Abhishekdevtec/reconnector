require "test_helper"

module Console
  class AgentsControllerTest < ActionDispatch::IntegrationTest
    include Devise::Test::IntegrationHelpers

    setup do
      @overlord = overlords(:one)
      @account = accounts(:one)
      @agent = agents(:bill)
    end

    test "should get index" do
      get console_account_agents_url(@account)
      assert_redirected_to new_overlord_session_path

      sign_in @overlord
      get console_account_agents_url(@account)
      assert_response :success
      sign_out :overlord
    end

    test "should get new" do
      get new_console_account_agent_url(@account)
      assert_redirected_to new_overlord_session_path

      sign_in @overlord
      get new_console_account_agent_url(@account)
      assert_response :success
      sign_out :overlord
    end

    test "should create account" do
      first_name = 'Firstname'
      last_name  = 'Lastname'
      email      = 'email@address.com'
      password   = 'password'

      post console_account_agents_url(@account), params: { agent: { account_id: @account.id, first_name: first_name, last_name: last_name, email: email, password: password } }
      assert_redirected_to new_overlord_session_path

      sign_in @overlord
      assert_difference('Agent.count') do
        post console_account_agents_url(@account), params: { agent: { account_id: @account.id, first_name: first_name, last_name: last_name, email: email, password: password } }
      end
      assert_redirected_to console_account_agent_url(@account, Agent.last)
      sign_out :overlord
    end

    test "should show account" do
      get console_account_agent_url(@account, @agent)
      assert_redirected_to new_overlord_session_path

      sign_in @overlord
      get console_account_agent_url(@account, @agent)
      assert_response :success
      sign_out :overlord
    end

    test "should get edit" do
      get edit_console_account_agent_url(@account, @agent)
      assert_redirected_to new_overlord_session_path

      sign_in @overlord
      get edit_console_account_agent_url(@account, @agent)
      assert_response :success
      sign_out :overlord
    end

    test "should update account" do
      patch console_account_agent_url(@account, @agent), params: { agent: { first_name: 'FirstnamePatched' } }
      assert_redirected_to new_overlord_session_path

      sign_in @overlord
      patch console_account_agent_url(@account, @agent), params: { agent: { first_name: 'FirstnamePatched' } }
      assert_redirected_to console_account_agent_url(@account, @agent)
      sign_out :overlord
    end

    test "should destroy account" do
      delete console_account_agent_url(@account, @agent)
      assert_redirected_to new_overlord_session_path

      sign_in @overlord
      assert_difference('Agent.count', -1) do
        delete console_account_agent_url(@account, @agent)
      end
      assert_redirected_to console_account_url(@account)
      sign_out :overlord
    end
  end
end
