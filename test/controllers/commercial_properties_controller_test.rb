require 'test_helper'

class CommercialPropertiesControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @property = properties(:commercial_property)
    @agent = agents(:bill)
  end

  test 'should get commercial_property index' do
    get commercial_properties_path
    assert_redirected_to new_agent_session_path

    sign_in @agent
    get commercial_properties_path
    assert_response :success
    assert_select 'h1', 'Properties'
    sign_out :agent
  end

  test 'should get new commercial_property' do
    get new_commercial_property_path
    assert_redirected_to new_agent_session_path

    sign_in @agent
    get new_commercial_property_path
    assert_response :success
    assert_select 'h1', 'New Commercial property'
    sign_out :agent
  end

  test 'should create commercial_property' do
    post commercial_properties_path, params: new_property_params
    assert_redirected_to new_agent_session_path

    sign_in @agent
    assert_difference('CommercialProperty.count') do
      post commercial_properties_path, params: new_property_params
    end
    created_property = CommercialProperty.unscoped.last
    new_property_params[:commercial_property].keys.each do |key|
      if rich_text_attributes.include?(key)
        assert_equal new_property_params[:commercial_property][key], created_property.public_send(key.to_s).to_plain_text
      else
        assert_equal new_property_params[:commercial_property][key], created_property.public_send(key.to_s)
      end
    end
    assert_redirected_to commercial_property_url(created_property)
    follow_redirect!
    assert_select 'h1', created_property.name
    sign_out :agent
  end

  test 'should show property' do
    get commercial_property_url(@property)
    assert_redirected_to new_agent_session_path

    sign_in @agent
    get commercial_property_url(@property)
    assert_response :success
    assert_select 'h1', @property.name
    sign_out :agent
  end

  test 'should get edit' do
    get edit_commercial_property_url(@property)
    assert_redirected_to new_agent_session_path

    sign_in @agent
    get edit_commercial_property_url(@property)
    assert_response :success
    sign_out :agent
  end

  test 'should update property' do
    patch commercial_property_url(@property), params: update_property_params
    assert_redirected_to new_agent_session_path

    sign_in @agent
    patch commercial_property_url(@property), params: update_property_params
    assert_redirected_to commercial_property_url(@property)
    updated_property = Property.find(@property.id)
    update_property_params[:commercial_property].keys.each do |key|
      if rich_text_attributes.include?(key)
        assert_equal update_property_params[:commercial_property][key], updated_property.public_send(key.to_s).to_plain_text
      else
        assert_equal update_property_params[:commercial_property][key], updated_property.public_send(key.to_s)
      end
    end
    follow_redirect!
    assert_select 'h1', updated_property.name
    sign_out :agent
  end

  private

  def new_property_params
    {
      commercial_property: {
        agent_id: @agent.id,
        brochure_description: 'new_brochure_description',
        building: 'new_building',
        city: 'new_city',
        clear_span_columns: 'new_clear_span_columns',
        country: 'new_country',
        crane: 'new_crane',
        disability_access: 'new_disability_access',
        entrances_roller_doors_container_access: 'new_entrances_roller_doors_container_access',
        estate: 'new_estate',
        fit_out: 'new_fit_out',
        floor_area: 999,
        floor_level: 'new_floor_level',
        floor: 'new_floor',
        furniture: 'new_furniture',
        grabline: 'new_grabline',
        hard_stand_yard_area: 888,
        headline: 'new_headline',
        keywords: 'new_keywords',
        land_area: 777,
        lifts_escalators_travelators: 'new_lifts_escalators_travelators',
        max_clearance_height: 9999.00,
        min_clearance_height: 1111.00,
        name: 'new_name',
        naming_rights_cost: 10_000,
        naming_rights: 'new_naming_rights',
        notes: 'new_notes',
        office_area: 666,
        parking_comments: 'new_parking_comments',
        parking_spaces: 99,
        postal_code: 'new_postal_code',
        production_area: 555,
        rating: 'new_rating',
        showroom_area: 444,
        state: 'new_state',
        storage_area: 333,
        street_name: 'new_street_name',
        street_number: 'new_street_number',
        unit_suite_shop: 'new_unit_suite_shop',
        trading_area: 222,
        type: 'CommercialProperty',
        unique_space_deprecated: 'new_unique_space_deprecated',
        usages: ['Offices'],
        warehouse_area: 111,
        website_description: 'new_website_description',
        zoning: 'new_zoning'
      }
    }
  end

  def update_property_params
    {
      commercial_property: {
        agent_id: @agent.id,
        brochure_description: 'updated_brochure_description',
        building: 'updated_building',
        city: 'updated_city',
        clear_span_columns: 'updated_clear_span_columns',
        country: 'updated_country',
        crane: 'updated_crane',
        disability_access: 'updated_disability_access',
        entrances_roller_doors_container_access: 'updated_entrances_roller_doors_container_access',
        estate: 'updated_estate',
        fit_out: 'updated_fit_out',
        floor_area: 999,
        floor_level: 'updated_floor_level',
        floor: 'updated_floor',
        furniture: 'updated_furniture',
        grabline: 'updated_grabline',
        hard_stand_yard_area: 888,
        headline: 'updated_headline',
        keywords: 'updated_keywords',
        land_area: 777,
        lifts_escalators_travelators: 'updated_lifts_escalators_travelators',
        max_clearance_height: 9999.00,
        min_clearance_height: 1111.00,
        name: 'updated_name',
        naming_rights_cost: 10_000,
        naming_rights: 'updated_naming_rights',
        notes: 'updated_notes',
        office_area: 666,
        parking_comments: 'updated_parking_comments',
        parking_spaces: 99,
        postal_code: 'updated_postal_code',
        production_area: 555,
        rating: 'updated_rating',
        showroom_area: 444,
        state: 'updated_state',
        storage_area: 333,
        street_name: 'updated_street_name',
        street_number: 'updated_street_number',
        unit_suite_shop: 'updated_unit_suite_shop',
        trading_area: 222,
        type: 'ResidentialProperty',
        unique_space_deprecated: 'updated_unique_space_deprecated',
        usages: ['Offices'],
        warehouse_area: 111,
        website_description: 'updated_website_description',
        zoning: 'updated_zoning'
      }
    }
  end

  def rich_text_attributes
    %i(brochure_description fit_out furniture notes website_description)
  end
end
