require "application_system_test_case"

class PropertiesTest < ApplicationSystemTestCase
  setup do
    @property = properties(:one)
  end

  test "visiting the index" do
    visit properties_url
    assert_selector "h1", text: "Properties"
  end

  test "creating a Property" do
    visit properties_url
    click_on "New Property"

    fill_in "Agent", with: @property.agent_id
    fill_in "Building", with: @property.building
    fill_in "City", with: @property.city
    fill_in "Min clearance height", with: @property.min_clearance_height
    fill_in "Max clearance height", with: @property.max_clearance_height
    fill_in "Clear span columns", with: @property.clear_span_columns
    fill_in "Country", with: @property.country
    fill_in "Crane", with: @property.crane
    fill_in "Brochure Description", with: @property.brochure_description
    fill_in "Disability access", with: @property.disability_access
    fill_in "Entrances roller doors container access", with: @property.entrances_roller_doors_container_access
    fill_in "Estate", with: @property.estate
    fill_in "Website Description", with: @property.website_description
    fill_in "Fit out", with: @property.fit_out
    fill_in "Floor", with: @property.floor
    fill_in "Floor area", with: @property.floor_area
    fill_in "Floor level", with: @property.floor_level
    fill_in "Furniture", with: @property.furniture
    fill_in "Grabline", with: @property.grabline
    fill_in "Hard stand yard area", with: @property.hard_stand_yard_area
    fill_in "Headline", with: @property.headline
    fill_in "Keywords", with: @property.keywords
    fill_in "Land area", with: @property.land_area
    fill_in "Lifts escalators travelators", with: @property.lifts_escalators_travelators
    fill_in "Name", with: @property.name
    fill_in "Naming rights", with: @property.naming_rights
    fill_in "Naming rights cost cents", with: @property.naming_rights_cost_cents
    fill_in "Office area", with: @property.office_area
    fill_in "Parking comments", with: @property.parking_comments
    fill_in "Parking spaces", with: @property.parking_spaces
    fill_in "Postal code", with: @property.postal_code
    fill_in "Production area", with: @property.production_area
    fill_in "Rating", with: @property.rating
    fill_in "Showroom area", with: @property.showroom_area
    fill_in "State", with: @property.state
    fill_in "Storage area", with: @property.storage_area
    fill_in "Street name", with: @property.street_name
    fill_in "Street number", with: @property.street_number
    fill_in "Suite", with: @property.unit_suite_shop
    fill_in "Trading area", with: @property.trading_area
    fill_in "Type", with: @property.type
    fill_in "Unique space", with: @property.unique_space_deprecated
    fill_in "Usages", with: @property.usages
    fill_in "Warehouse area", with: @property.warehouse_area
    fill_in "Zoning", with: @property.zoning
    click_on "Create Property"

    assert_text "Property was successfully created"
    click_on "Back"
  end

  test "updating a Property" do
    visit properties_url
    click_on "Edit", match: :first

    fill_in "Agent", with: @property.agent_id
    fill_in "Building", with: @property.building
    fill_in "City", with: @property.city
    fill_in "Min clearance height", with: @property.min_clearance_height
    fill_in "Max clearance height", with: @property.max_clearance_height
    fill_in "Clear span columns", with: @property.clear_span_columns
    fill_in "Country", with: @property.country
    fill_in "Crane", with: @property.crane
    fill_in "Brochure Description", with: @property.brochure_description
    fill_in "Disability access", with: @property.disability_access
    fill_in "Entrances roller doors container access", with: @property.entrances_roller_doors_container_access
    fill_in "Estate", with: @property.estate
    fill_in "Website Description", with: @property.website_description
    fill_in "Fit out", with: @property.fit_out
    fill_in "Floor", with: @property.floor
    fill_in "Floor area", with: @property.floor_area
    fill_in "Floor level", with: @property.floor_level
    fill_in "Furniture", with: @property.furniture
    fill_in "Grabline", with: @property.grabline
    fill_in "Hard stand yard area", with: @property.hard_stand_yard_area
    fill_in "Headline", with: @property.headline
    fill_in "Keywords", with: @property.keywords
    fill_in "Land area", with: @property.land_area
    fill_in "Lifts escalators travelators", with: @property.lifts_escalators_travelators
    fill_in "Name", with: @property.name
    fill_in "Naming rights", with: @property.naming_rights
    fill_in "Naming rights cost cents", with: @property.naming_rights_cost_cents
    fill_in "Office area", with: @property.office_area
    fill_in "Parking comments", with: @property.parking_comments
    fill_in "Parking spaces", with: @property.parking_spaces
    fill_in "Postal code", with: @property.postal_code
    fill_in "Production area", with: @property.production_area
    fill_in "Rating", with: @property.rating
    fill_in "Showroom area", with: @property.showroom_area
    fill_in "State", with: @property.state
    fill_in "Storage area", with: @property.storage_area
    fill_in "Street name", with: @property.street_name
    fill_in "Street number", with: @property.street_number
    fill_in "Suite", with: @property.unit_suite_shop
    fill_in "Trading area", with: @property.trading_area
    fill_in "Type", with: @property.type
    fill_in "Unique space", with: @property.unique_space_deprecated
    fill_in "Usages", with: @property.usages
    fill_in "Warehouse area", with: @property.warehouse_area
    fill_in "Zoning", with: @property.zoning
    click_on "Update Property"

    assert_text "Property was successfully updated"
    click_on "Back"
  end

  test "destroying a Property" do
    visit properties_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Property was successfully destroyed"
  end
end
