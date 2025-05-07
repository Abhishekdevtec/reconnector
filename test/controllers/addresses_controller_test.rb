# frozen_string_literal: true

require 'test_helper'

class AddressesControllerTest < ActionController::TestCase
  include Devise::Test::ControllerHelpers

  setup do
    @current_agent = agents(:bill)
    sign_in @current_agent
  end

  test 'should get states' do
    country = countries(:australia) # Assuming you have fixture data
    get :states, params: { country: country.slug, target: 'target_value' }, format: :turbo_stream
    assert_response :success
    assert_not_nil assigns(:states)
  end

  test 'should get cities' do
    state = states(:nsw) # Assuming you have fixture data
    get :cities, params: { state: state.id, target: 'target_value' }, format: :turbo_stream
    assert_response :success
    assert_not_nil assigns(:cities)
  end
end
