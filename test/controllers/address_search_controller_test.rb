require 'test_helper'

class AddressSearchControllerTest < ActionController::TestCase
  include Devise::Test::ControllerHelpers

  setup do
    @current_agent = agents(:bill)
    sign_in @current_agent
  end

  teardown do
    sign_out :agent
  end

  test 'should get index' do
    VCR.use_cassette('address_search_controller_should_get_index_test') do
      get :index, params: { address: '93-95 Derby St, Silverwater, Australia', target: 'target_value' }, format: :turbo_stream
    end
    assert_response :success
    assert_not_nil assigns(:addresses)
  end
end
