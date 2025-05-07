require 'test_helper'

module Console
  class ContactsControllerTest < ActionDispatch::IntegrationTest
    include Devise::Test::IntegrationHelpers

    setup do
      @overlord = overlords(:one)
      @account = accounts(:one)
      @contact = @account.contacts.last
    end

    test 'should get index' do
      get console_account_contacts_url(@account)
      assert_redirected_to new_overlord_session_path

      sign_in @overlord
      get console_account_contacts_url(@account)
      assert_response :success
      sign_out :overlord
    end

    test 'should get new' do
      get new_console_account_contact_url(@account)
      assert_redirected_to new_overlord_session_path

      sign_in @overlord
      get new_console_account_contact_url(@account)
      assert_response :success
      sign_out :overlord
    end

    # test 'should create contact' do
    #   post console_account_contacts_url(@account), params: { contact: { account_id: @contact.account_id, agent_id: @contact.agent_id, business_name: @contact.business_name, email: @contact.email, fax: @contact.fax, first_name: @contact.first_name, job_title: @contact.job_title, last_name: @contact.last_name, legal_name: @contact.legal_name, mobile: @contact.mobile, notes: @contact.notes, phone: @contact.phone, registration: @contact.registration, share: @contact.share, type: @contact.type, url: @contact.url } }
    #   assert_redirected_to new_overlord_session_path

    #   sign_in @overlord
    #   assert_difference('Contact.count') do
    #     post console_account_contacts_url(@account), params: { contact: { account_id: @contact.account_id, agent_id: @contact.agent_id, business_name: @contact.business_name, email: @contact.email, fax: @contact.fax, first_name: @contact.first_name, job_title: @contact.job_title, last_name: @contact.last_name, legal_name: @contact.legal_name, mobile: @contact.mobile, notes: @contact.notes, phone: @contact.phone, registration: @contact.registration, share: @contact.share, type: @contact.type, url: @contact.url } }
    #   end
    #   assert_redirected_to console_account_contact_url(@account, Contact.last)
    #   sign_out :overlord
    # end

    test 'should show individual' do
      individual = @account.individuals.last
      get console_account_individual_path(@account, individual)
      assert_redirected_to new_overlord_session_path

      sign_in @overlord
      get console_account_individual_path(@account, individual)
      assert_response :success
      sign_out :overlord
    end

    test 'should get edit individual' do
      individual = @account.individuals.last

      get edit_console_account_path(@account, individual)
      assert :forbidden

      sign_in @overlord
      get edit_console_account_path(@account, individual)
      assert_response :success
      sign_out :overlord
    end

    test 'should get edit business' do
      business = @account.businesses.last

      get edit_console_account_path(@account, business)
      assert :forbidden

      sign_in @overlord
      get edit_console_account_path(@account, business)
      assert_response :success
      sign_out :overlord
    end

    # test 'should update contact' do
    #   patch console_account_contact_url(@account, @contact), params: { contact: { account_id: @contact.account_id, agent_id: @contact.agent_id, business_name: @contact.business_name, email: @contact.email, fax: @contact.fax, first_name: @contact.first_name, job_title: @contact.job_title, last_name: @contact.last_name, legal_name: @contact.legal_name, mobile: @contact.mobile, notes: @contact.notes, phone: @contact.phone, registration: @contact.registration, share: @contact.share, type: @contact.type, url: @contact.url } }
    #   assert_redirected_to new_overlord_session_path

    #   sign_in @overlord
    #   patch console_account_contact_url(@account, @contact), params: { contact: { account_id: @contact.account_id, agent_id: @contact.agent_id, business_name: @contact.business_name, email: @contact.email, fax: @contact.fax, first_name: @contact.first_name, job_title: @contact.job_title, last_name: @contact.last_name, legal_name: @contact.legal_name, mobile: @contact.mobile, notes: @contact.notes, phone: @contact.phone, registration: @contact.registration, share: @contact.share, type: @contact.type, url: @contact.url } }
    #   assert_redirected_to console_account_contact_url(@account, @contact)
    #   sign_out :overlord
    # end

    test 'should destroy contact' do
      delete console_account_contact_url(@account, @contact)
      assert_redirected_to new_overlord_session_path

      sign_in @overlord
      assert_difference('Contact.count', -1) do
        delete console_account_contact_url(@account, @contact)
      end
      assert_redirected_to console_account_contacts_url(@account)
      sign_out :overlord
    end
  end
end
