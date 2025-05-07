require 'test_helper'

module Console
  class PropertiesControllerTest < ActionDispatch::IntegrationTest
    include Devise::Test::IntegrationHelpers

    setup do
      @overlord = overlords(:one)
      @account = accounts(:one)
      @property = properties(:industrial_property)
      @agent = agents(:bill)
    end

    test 'should get index' do
      get console_account_properties_url(@account)
      assert_redirected_to new_overlord_session_path

      sign_in @overlord
      get console_account_properties_url(@account)
      assert_response :success
      sign_out :overlord
    end

    test 'should get new' do
      get new_console_account_property_url(@account)
      assert_redirected_to new_overlord_session_path

      sign_in @overlord
      get new_console_account_property_url(@account)
      assert_response :success
      sign_out :overlord
    end

    test 'should create property' do
      post console_account_properties_url(@account), params: { property: { type: @property.type, agent_id: @property.agent_id, building: @property.building, city: @property.city, min_clearance_height: @property.min_clearance_height, max_clearance_height: @property.max_clearance_height, clear_span_columns: @property.clear_span_columns, country: @property.country, crane: @property.crane, brochure_description: @property.brochure_description, disability_access: @property.disability_access, entrances_roller_doors_container_access: @property.entrances_roller_doors_container_access, estate: @property.estate, website_description: @property.website_description, fit_out: @property.fit_out, floor: @property.floor, floor_area: @property.floor_area, floor_level: @property.floor_level, furniture: @property.furniture, grabline: @property.grabline, hard_stand_yard_area: @property.hard_stand_yard_area, headline: @property.headline, keywords: @property.keywords, land_area: @property.land_area, lifts_escalators_travelators: @property.lifts_escalators_travelators, name: @property.name, naming_rights: @property.naming_rights, naming_rights_cost_cents: @property.naming_rights_cost_cents, office_area: @property.office_area, parking_comments: @property.parking_comments, parking_spaces: @property.parking_spaces, postal_code: @property.postal_code, production_area: @property.production_area, rating: @property.rating, showroom_area: @property.showroom_area, state: @property.state, storage_area: @property.storage_area, street_name: @property.street_name, street_number: @property.street_number, unit_suite_shop: @property.unit_suite_shop, trading_area: @property.trading_area, unique_space_deprecated: @property.unique_space_deprecated, usages: @property.usages, warehouse_area: @property.warehouse_area, zoning: @property.zoning } }
      assert_redirected_to new_overlord_session_path

      sign_in @overlord
      assert_difference('Property.count') do
        post console_account_properties_url(@account), params: { property: { type: @property.type, agent_id: @property.agent_id, building: @property.building, city: @property.city, min_clearance_height: @property.min_clearance_height, max_clearance_height: @property.max_clearance_height, clear_span_columns: @property.clear_span_columns, country: @property.country, crane: @property.crane, brochure_description: @property.brochure_description, disability_access: @property.disability_access, entrances_roller_doors_container_access: @property.entrances_roller_doors_container_access, estate: @property.estate, website_description: @property.website_description, fit_out: @property.fit_out, floor: @property.floor, floor_area: @property.floor_area, floor_level: @property.floor_level, furniture: @property.furniture, grabline: @property.grabline, hard_stand_yard_area: @property.hard_stand_yard_area, headline: @property.headline, keywords: @property.keywords, land_area: @property.land_area, lifts_escalators_travelators: @property.lifts_escalators_travelators, name: @property.name, naming_rights: @property.naming_rights, naming_rights_cost_cents: @property.naming_rights_cost_cents, office_area: @property.office_area, parking_comments: @property.parking_comments, parking_spaces: @property.parking_spaces, postal_code: @property.postal_code, production_area: @property.production_area, rating: @property.rating, showroom_area: @property.showroom_area, state: @property.state, storage_area: @property.storage_area, street_name: @property.street_name, street_number: @property.street_number, unit_suite_shop: @property.unit_suite_shop, trading_area: @property.trading_area, unique_space_deprecated: @property.unique_space_deprecated, usages: @property.usages, warehouse_area: @property.warehouse_area, zoning: @property.zoning } }
      end
      assert_redirected_to console_account_property_url(@account, @account.properties.unscoped.last)
      sign_out :overlord
    end

    test 'should show property' do
      get console_account_property_url(@account, @property)
      assert_redirected_to new_overlord_session_path

      sign_in @overlord
      get console_account_property_url(@account, @property)
      assert_response :success
      sign_out :overlord
    end

    test 'should get edit' do
      get edit_console_account_property_url(@account, @property)
      assert_redirected_to new_overlord_session_path

      sign_in @overlord
      get edit_console_account_property_url(@account, @property)
      assert_response :success
      sign_out :overlord
    end

    test 'should update property' do
      patch console_account_property_url(@account, @property), params: { property: { agent_id: @agent.id, building: @property.building, city: @property.city, min_clearance_height: @property.min_clearance_height, max_clearance_height: @property.max_clearance_height, clear_span_columns: @property.clear_span_columns, country: @property.country, crane: @property.crane, brochure_description: @property.brochure_description, disability_access: @property.disability_access, entrances_roller_doors_container_access: @property.entrances_roller_doors_container_access, estate: @property.estate, website_description: @property.website_description, fit_out: @property.fit_out, floor: @property.floor, floor_area: @property.floor_area, floor_level: @property.floor_level, furniture: @property.furniture, grabline: @property.grabline, hard_stand_yard_area: @property.hard_stand_yard_area, headline: @property.headline, keywords: @property.keywords, land_area: @property.land_area, lifts_escalators_travelators: @property.lifts_escalators_travelators, name: @property.name, naming_rights: @property.naming_rights, naming_rights_cost_cents: @property.naming_rights_cost_cents, office_area: @property.office_area, parking_comments: @property.parking_comments, parking_spaces: @property.parking_spaces, postal_code: @property.postal_code, production_area: @property.production_area, rating: @property.rating, showroom_area: @property.showroom_area, state: @property.state, storage_area: @property.storage_area, street_name: @property.street_name, street_number: @property.street_number, unit_suite_shop: @property.unit_suite_shop, trading_area: @property.trading_area, type: @property.type, unique_space_deprecated: @property.unique_space_deprecated, usages: @property.usages, warehouse_area: @property.warehouse_area, zoning: @property.zoning } }
      assert_redirected_to new_overlord_session_path

      sign_in @overlord
      patch console_account_property_url(@account, @property), params: { property: { agent_id: @agent.id, building: @property.building, city: @property.city, min_clearance_height: @property.min_clearance_height, max_clearance_height: @property.max_clearance_height, clear_span_columns: @property.clear_span_columns, country: @property.country, crane: @property.crane, brochure_description: @property.brochure_description, disability_access: @property.disability_access, entrances_roller_doors_container_access: @property.entrances_roller_doors_container_access, estate: @property.estate, website_description: @property.website_description, fit_out: @property.fit_out, floor: @property.floor, floor_area: @property.floor_area, floor_level: @property.floor_level, furniture: @property.furniture, grabline: @property.grabline, hard_stand_yard_area: @property.hard_stand_yard_area, headline: @property.headline, keywords: @property.keywords, land_area: @property.land_area, lifts_escalators_travelators: @property.lifts_escalators_travelators, name: @property.name, naming_rights: @property.naming_rights, naming_rights_cost_cents: @property.naming_rights_cost_cents, office_area: @property.office_area, parking_comments: @property.parking_comments, parking_spaces: @property.parking_spaces, postal_code: @property.postal_code, production_area: @property.production_area, rating: @property.rating, showroom_area: @property.showroom_area, state: @property.state, storage_area: @property.storage_area, street_name: @property.street_name, street_number: @property.street_number, unit_suite_shop: @property.unit_suite_shop, trading_area: @property.trading_area, type: @property.type, unique_space_deprecated: @property.unique_space_deprecated, usages: @property.usages, warehouse_area: @property.warehouse_area, zoning: @property.zoning } }
      assert_redirected_to console_account_property_url(@account, @property)
      sign_out :overlord
    end

    test 'should destroy property' do
      delete console_account_property_url(@account, @property)
      assert_redirected_to new_overlord_session_path

      sign_in @overlord
      assert_difference('Property.count', -1) do
        delete console_account_property_url(@account, @property)
      end
      assert_redirected_to console_account_properties_url(@account)
      sign_out :overlord
    end
  end
end
