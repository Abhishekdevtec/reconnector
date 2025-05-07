require "application_system_test_case"

class PropertyContactsTest < ApplicationSystemTestCase
  setup do
    @property_contact = property_contacts(:one)
  end

  test "visiting the index" do
    visit property_contacts_url
    assert_selector "h1", text: "Property Contacts"
  end

  test "creating a Property contact" do
    visit property_contacts_url
    click_on "New Property Contact"

    fill_in "Classifier", with: @property_contact.classifier
    fill_in "Contact", with: @property_contact.contact_id
    fill_in "Property", with: @property_contact.property_id
    click_on "Create Property contact"

    assert_text "Property contact was successfully created"
    click_on "Back"
  end

  test "updating a Property contact" do
    visit property_contacts_url
    click_on "Edit", match: :first

    fill_in "Classifier", with: @property_contact.classifier
    fill_in "Contact", with: @property_contact.contact_id
    fill_in "Property", with: @property_contact.property_id
    click_on "Update Property contact"

    assert_text "Property contact was successfully updated"
    click_on "Back"
  end

  test "destroying a Property contact" do
    visit property_contacts_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Property contact was successfully destroyed"
  end
end
