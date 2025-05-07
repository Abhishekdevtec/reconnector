require 'test_helper'

class Console::ClassifiersControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @overlord = overlords(:one)
    @account = accounts(:one)
  end

  # test 'should get index' do
  #   get console_account_classifiers_url(@account)
  #   assert_redirected_to new_overlord_session_path

  #   sign_in @overlord
  #   get console_account_classifiers_url(@account)
  #   assert_response :success
  #   sign_out :overlord
  # end

  # test 'should get new' do
  #   get new_console_account_classifier_url(@account)
  #   assert_redirected_to new_overlord_session_path

  #   sign_in @overlord
  #   get new_console_account_classifier_url(@account)
  #   assert_response :success
  #   sign_out :overlord
  # end

  # test 'should create classifier' do
  #   params = {
  #     classifier: {
  #       name: 'The classy fire',
  #       account_id: @account.id
  #     }
  #   }
  #   post console_account_classifiers_url(@account), params: params
  #   assert_redirected_to new_overlord_session_path

  #   sign_in @overlord
  #   assert_difference('Classifier.count') do
  #     post console_account_classifiers_url(@account), params: params
  #   end
  #   assert_redirected_to console_account_classifier_url(@account, Classifier.unscoped.last)
  #   sign_out :overlord
  # end

  # test 'should show classifier' do
  #   get console_account_classifier_url(@account, @classifier)
  #   assert_redirected_to new_overlord_session_path

  #   sign_in @overlord
  #   get console_account_classifier_url(@account, @classifier)
  #   assert_response :success
  #   sign_out :overlord
  # end

  # test 'should get edit' do
  #   get edit_console_account_classifier_url(@account, @classifier)
  #   assert_redirected_to new_overlord_session_path

  #   sign_in @overlord
  #   get edit_console_account_classifier_url(@account, @classifier)
  #   assert_response :success
  #   sign_out :overlord
  # end

  # test 'should update classifier' do
  #   patch console_account_classifier_url(@account, @classifier), params: { classifier: { account_id: @classifier.account_id, name: @classifier.name } }
  #   assert_redirected_to new_overlord_session_path

  #   sign_in @overlord
  #   patch console_account_classifier_url(@account, @classifier), params: { classifier: { account_id: @classifier.account_id, name: @classifier.name } }
  #   assert_redirected_to console_account_classifier_url(@account, @classifier)
  #   sign_out :overlord
  # end

  # test 'should destroy classifier' do
  #   delete console_account_classifier_url(@account, @classifier)
  #   assert_redirected_to new_overlord_session_path

  #   sign_in @overlord
  #   assert_difference('Classifier.count', -1) do
  #     delete console_account_classifier_url(@account, @classifier)
  #   end
  #   assert_redirected_to console_account_classifiers_url
  #   sign_out :overlord
  # end
end
