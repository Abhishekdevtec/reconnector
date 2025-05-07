require 'test_helper'

class PropertiesControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @property = properties(:industrial_property)
    @agent = agents(:bill)
  end

  test 'should get index' do
    get properties_url
    assert_redirected_to new_agent_session_path

    sign_in @agent
    get properties_url
    assert_response :success
    sign_out :agent
  end

  test 'should show property' do
    get property_url(@property)
    assert_redirected_to new_agent_session_path

    sign_in @agent
    get property_url(@property)
    assert_response :success
    sign_out :agent
  end

  test 'should destroy property' do
    delete property_url(@property)
    assert_redirected_to new_agent_session_path

    sign_in @agent
    assert_difference('Property.count', -1) do
      delete property_url(@property)
    end
    assert_redirected_to properties_url
    sign_out :agent
  end

  test 'index should display shared properties' do
    sign_in @agent
    agent_property_ids  = @agent.properties.pluck(:id)
    shared_property_ids = @agent.account.properties.where(share: true).pluck(:id)
    shared_properties = Property.where(id: [agent_property_ids + shared_property_ids].uniq)
    get properties_url
    assert_response :success

    assert_includes assigns(:properties), shared_properties

    sign_out :agent
  end
end
