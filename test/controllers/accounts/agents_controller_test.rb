# frozen_string_literal: true

require 'test_helper'

module Accounts
  class AgentsControllerTest < ActionDispatch::IntegrationTest
    include Devise::Test::IntegrationHelpers

    setup do
      @account = accounts(:one)
      @agent = agents(:agent)
      @account_manager = agents(:account_manager)
    end

    teardown do
      sign_out :agent
    end

    test 'should get index if account_manager' do
      sign_in @account_manager
      get account_agents_url(@account)
      assert_response :success
    end

    test 'should get redirected from index if not account_manager' do
      sign_in @agent
      get account_agents_url(@account)
      assert_redirected_to agent_root_path
    end

    test 'should get new if account_manager' do
      sign_in @account_manager
      get new_account_agent_url(@account)
      assert_response :success
    end

    test 'should get redirected from new if account_manager' do
      sign_in @agent
      get new_account_agent_url(@account)
      assert_redirected_to agent_root_path
    end

    test 'should create agent if account_manager' do
      sign_in @account_manager
      assert_difference('Agent.count') do
        post account_agents_url(@account), params: { agent: { email: 'test@example.com', first_name: 'Test', last_name: 'User', mobile: '1234567890', phone: '0987654321', role: 'agent' } }
      end

      assert_redirected_to account_agents_url(@account)
    end

    test 'should not create agent if agent' do
      sign_in @agent
      assert_no_difference('Agent.count') do
        post account_agents_url(@account), params: { agent: { email: 'test@example.com', first_name: 'Test', last_name: 'User', mobile: '1234567890', phone: '0987654321', role: 'agent' } }
      end

      assert_redirected_to agent_root_path
    end

    test 'should get edit if account_manager' do
      sign_in @account_manager
      get edit_account_agent_url(@agent)
      assert_response :success
    end

    test 'should get redirected from edit if agent' do
      sign_in @agent
      get edit_account_agent_url(@account, @agent)
      assert_redirected_to agent_root_path
    end

    test 'should update agent' do
      sign_in @account_manager
      patch account_agent_url(@agent), params: { agent: { email: @agent.email, first_name: @agent.first_name, last_name: @agent.last_name, mobile: @agent.mobile, phone: @agent.phone, role: @agent.role } }
      assert_redirected_to account_agents_url(@account)
    end

    test 'should not update agent if agent' do
      sign_in @agent
      patch account_agent_url(@agent), params: { agent: { email: @agent.email, first_name: @agent.first_name, last_name: @agent.last_name, mobile: @agent.mobile, phone: @agent.phone, role: @agent.role } }
      assert_redirected_to agent_root_path
    end

    test 'should not create agent with invalid params' do
      sign_in @account_manager
      assert_no_difference('Agent.count') do
        post account_agents_url(@agent), params: { agent: { email: nil, first_name: nil, last_name: nil, mobile: nil, phone: nil, role: nil } }
      end

      assert_response :redirect
    end

    test 'should not update agent with invalid params' do
      sign_in @account_manager
      patch account_agent_url(@agent), params: { agent: { email: nil, first_name: nil, last_name: nil, mobile: nil, phone: nil, role: nil } }
      assert_response :redirect
    end
  end
end
