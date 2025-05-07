require "test_helper"

class ContactsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @agent = agents(:bill)
  end

  test 'should get contacts only when connected' do
    get contacts_url
    assert_redirected_to new_agent_session_path

    sign_in @agent
    get contacts_url
    assert_response :success
    assert_select 'h1', 'Contacts'
    sign_out :agent
  end
end
