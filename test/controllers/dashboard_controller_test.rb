require "test_helper"

class DashboardControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @agent = agents(:bill)
  end

  test "should get dashboard only when connected as agent" do
    get agent_root_url
    assert_redirected_to new_agent_session_path

    sign_in @agent
    get agent_root_url
    assert_response :success
    sign_out :agent
  end
end
