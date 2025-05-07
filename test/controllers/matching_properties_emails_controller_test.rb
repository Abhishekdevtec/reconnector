require 'test_helper'

class MatchingPropertiesEmailsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @matching_properties_email = matching_properties_emails(:one)
    @contact = @matching_properties_email.contact
    @agent = agents(:bill)
  end

  test 'should get new' do
    get new_contact_matching_properties_email_path(@contact)
    assert_redirected_to new_agent_session_path

    sign_in @agent
    get new_contact_matching_properties_email_path(@contact)
    assert_response :success
    sign_out :agent
  end

  test 'should create matching_properties_email' do
    params = {
      matching_properties_email: {
        body: 'This is the body',
        attach_brochures: false
      },
      property_ids: [@agent.properties.first.id]
    }
    post contact_matching_properties_emails_path(@contact), params: params
    assert_redirected_to new_agent_session_path

    sign_in @agent
    assert_difference('MatchingPropertiesEmail.count') do
      VCR.use_cassette('send_matching_properties_emails') do
        post contact_matching_properties_emails_path(@contact), params: params
      end
    end
    assert_redirected_to individual_path(@contact)
    sign_out :agent
  end
end
