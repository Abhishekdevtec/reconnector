require 'test_helper'

module Contacts
  class PropertyRequirementsControllerTest < ActionDispatch::IntegrationTest
    def setup
      # Set up any necessary objects or data needed for this test
      @contact = contacts(:business)
      @property_requirements = property_requirements(:one)
    end

    # test 'should get index' do
    #   # Send a request to the index action
    #   get contact_property_requirements_path(@contact), params: { contact_id: @contact.id }

    #   # Expect the instance variable @property_requirements to be assigned
    #   # the list of property requirements for the contact
    #   assert_equal @property_requirements, assigns(:property_requirements)

    #   # Expect the controller to render the index template
    #   assert_template :index
    # end

    # test 'should create a property requirement' do
    #   property_requirement_params = {
    #     property_type: 'Commercial',
    #     district_id: 1,
    #     for_sale: true,
    #     for_lease: false,
    #     area_from: 100,
    #     area_to: 200,
    #     price_from_cents: 100_000,
    #     price_to_cents: 200_000,
    #     suburbs: ['Inner City', 'Outer City'],
    #     contact: @contact
    #   }

    #   # Send a request to the create action with the property requirement params
    #   post contact_matching_properties_emails_path(@contact), params: { contact_id: @contact.id, property_requirement: property_requirement_params }

    #   # Expect a new property requirement to be created
    #   assert_difference 'PropertyRequirement.count', 1 do
    #     post contact_matching_properties_emails_path(@contact), params: { contact_id: @contact.id, property_requirement: property_requirement_params }
    #   end

    #   # Expect the controller to redirect to the contact show page
    #   assert_redirected_to @contact

    #   # Expect a flash message to be set
    #   assert_equal 'Property requirements added', flash[:notice]
    # end
  end
end
