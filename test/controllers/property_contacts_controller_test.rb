require "test_helper"

class PropertyContactsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @property = properties(:with_contact)
    @property_contact = property_contacts(:one)
    @agent = @property.agent
  end

  test "should get index" do
    get property_property_contacts_url(@property)
    assert_redirected_to new_agent_session_path

    sign_in @agent
    get property_property_contacts_url(@property)
    assert_response :success
    sign_out :agent
  end

  test "should get new" do
    get new_property_property_contact_path(@property)
    assert_redirected_to new_agent_session_path

    sign_in @agent
    get new_property_property_contact_path(@property)
    assert_response :success
    sign_out :agent
  end

  test "should create property_contact" do
    property = properties(:industrial_property)
    post property_property_contacts_path(property), params: { property_contact: { contact_id: @property_contact.contact_id, property_id: @property.id, classifications: ['Vendor'] } }
    assert_redirected_to new_agent_session_path

    sign_in @agent
    assert_difference('PropertyContact.count') do
      post property_property_contacts_path(property), params: { property_contact: { contact_id: @property_contact.contact_id, property_id: @property.id, classifications: ['Vendor'] } }
    end
    assert_redirected_to property_property_contacts_path(property)
    sign_out :agent
  end

  test "should show property_contact" do
    get property_property_contact_path(@property, @property_contact)
    assert_redirected_to new_agent_session_path

    sign_in @agent
    get property_property_contact_path(@property, @property_contact)
    assert_response :success
    sign_out :agent
  end

  test "should get edit" do
    get edit_property_property_contact_path(@property, @property_contact)
    assert_redirected_to new_agent_session_path

    sign_in @agent
    get edit_property_property_contact_path(@property, @property_contact)
    assert_response :success
    sign_out :agent
  end

  test "should update property_contact" do
    patch property_property_contact_path(@property, @property_contact), params: { property_contact: { contact_id: @property_contact.contact_id, property_id: @property_contact.property_id, classifications: ['Vendor'] } }
    assert_redirected_to new_agent_session_path

    sign_in @agent
    patch property_property_contact_path(@property, @property_contact), params: { property_contact: { contact_id: @property_contact.contact_id, property_id: @property_contact.property_id, classifications: ['Vendor'] } }
    assert_redirected_to property_path(@property)
    sign_out :agent
  end

  test "should destroy property_contact" do
    delete property_property_contact_path(@property, @property_contact)
    assert_redirected_to new_agent_session_path

    sign_in @agent
    assert_difference('PropertyContact.count', -1) do
      delete property_property_contact_path(@property, @property_contact)
    end
    assert_redirected_to url_for(@property)
    sign_out :agent
  end
end
