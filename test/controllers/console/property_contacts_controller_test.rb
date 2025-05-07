require 'test_helper'

module Console
  class PropertyContactsControllerTest < ActionDispatch::IntegrationTest
    include Devise::Test::IntegrationHelpers

    setup do
      @overlord = overlords(:one)
      @account = accounts(:one)
      @property = properties(:with_contact)
      @property_contact = property_contacts(:one)
    end

    test 'should get index' do
      get console_account_property_property_contacts_url(@account, @property)
      assert_redirected_to new_overlord_session_path

      sign_in @overlord
      get console_account_property_property_contacts_url(@account, @property)
      assert_response :success
      sign_out :overlord
    end

    test 'should get new' do
      get new_console_account_property_property_contact_path(@account, @property)
      assert_redirected_to new_overlord_session_path

      sign_in @overlord
      get new_console_account_property_property_contact_path(@account, @property)
      assert_response :success
      sign_out :overlord
    end

    test 'should create property_contact' do
      @property.property_contacts.destroy_all
      params = {
        property_contact: {
          property_id: @property.id,
          contact_id: @property.agent.contacts.first.id,
          classifications: ['Owner']
        }
      }

      post console_account_property_property_contacts_path(@account, @property), params: params
      assert_redirected_to new_overlord_session_path

      sign_in @overlord
      assert_difference('PropertyContact.count') do
        post console_account_property_property_contacts_path(@account, @property), params: params
      end
      assert_redirected_to console_account_property_path(@account, @property)
      sign_out :overlord
    end

    test 'should show property_contact' do
      get console_account_property_property_contact_path(@account, @property, @property_contact)
      assert_redirected_to new_overlord_session_path

      sign_in @overlord
      get console_account_property_property_contact_path(@account, @property, @property_contact)
      assert_response :success
      sign_out :overlord
    end

    test 'should get edit' do
      get edit_console_account_property_property_contact_path(@account, @property, @property_contact)
      assert_redirected_to new_overlord_session_path

      sign_in @overlord
      get edit_console_account_property_property_contact_path(@account, @property, @property_contact)
      assert_response :success
      sign_out :overlord
    end

    test 'should update property_contact' do
      patch console_account_property_property_contact_path(@account, @property, @property_contact), params: { property_contact: { contact_id: @property_contact.contact_id, property_id: @property_contact.property_id, classifications: ['Vendor'] } }
      assert_redirected_to new_overlord_session_path

      sign_in @overlord
      patch console_account_property_property_contact_path(@account, @property, @property_contact), params: { property_contact: { contact_id: @property_contact.contact_id, property_id: @property_contact.property_id, classifications: ['Vendor'] } }
      assert_redirected_to console_account_property_path(@account, @property)
      sign_out :overlord
    end

    test 'should destroy property_contact' do
      delete console_account_property_property_contact_path(@account, @property, @property_contact)
      assert_redirected_to new_overlord_session_path

      sign_in @overlord
      assert_difference('PropertyContact.count', -1) do
        delete console_account_property_property_contact_path(@account, @property, @property_contact)
      end
      assert_redirected_to console_account_property_path(@account, @property)
      sign_out :overlord
    end
  end
end
