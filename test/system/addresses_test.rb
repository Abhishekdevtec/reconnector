require "application_system_test_case"

class AddressesTest < ApplicationSystemTestCase
  setup do
    @address = addresses(:one)
  end

  test "visiting the index" do
    visit addresses_url
    assert_selector "h1", text: "Addresses"
  end

  test "creating a Address" do
    visit addresses_url
    click_on "New Address"

    fill_in "Addressable", with: @address.addressable_id
    fill_in "Addressable type", with: @address.addressable_type
    fill_in "Category", with: @address.category
    fill_in "City", with: @address.city
    fill_in "Country", with: @address.country
    fill_in "Line 1", with: @address.line_1
    fill_in "Line 2", with: @address.line_2
    fill_in "Line 3", with: @address.line_3
    fill_in "Postal code", with: @address.postal_code
    fill_in "State", with: @address.state
    click_on "Create Address"

    assert_text "Address was successfully created"
    click_on "Back"
  end

  test "updating a Address" do
    visit addresses_url
    click_on "Edit", match: :first

    fill_in "Addressable", with: @address.addressable_id
    fill_in "Addressable type", with: @address.addressable_type
    fill_in "Category", with: @address.category
    fill_in "City", with: @address.city
    fill_in "Country", with: @address.country
    fill_in "Line 1", with: @address.line_1
    fill_in "Line 2", with: @address.line_2
    fill_in "Line 3", with: @address.line_3
    fill_in "Postal code", with: @address.postal_code
    fill_in "State", with: @address.state
    click_on "Update Address"

    assert_text "Address was successfully updated"
    click_on "Back"
  end

  test "destroying a Address" do
    visit addresses_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Address was successfully destroyed"
  end
end
