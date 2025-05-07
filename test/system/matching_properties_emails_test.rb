require "application_system_test_case"

class MatchingPropertiesEmailsTest < ApplicationSystemTestCase
  setup do
    @matching_properties_email = matching_properties_emails(:one)
  end

  test "visiting the index" do
    visit matching_properties_emails_url
    assert_selector "h1", text: "Matching property emails"
  end

  test "should create matching property email" do
    visit matching_properties_emails_url
    click_on "New matching property email"

    fill_in "Agent", with: @matching_properties_email.agent_id
    check "Attach brochures" if @matching_properties_email.attach_brochures
    fill_in "Contact", with: @matching_properties_email.contact_id
    fill_in "Email sent at", with: @matching_properties_email.email_sent_at
    fill_in "Property ids", with: @matching_properties_email.property_ids
    click_on "Create Matching property email"

    assert_text "Matching property email was successfully created"
    click_on "Back"
  end

  test "should update Matching property email" do
    visit matching_properties_email_url(@matching_properties_email)
    click_on "Edit this matching property email", match: :first

    fill_in "Agent", with: @matching_properties_email.agent_id
    check "Attach brochures" if @matching_properties_email.attach_brochures
    fill_in "Contact", with: @matching_properties_email.contact_id
    fill_in "Email sent at", with: @matching_properties_email.email_sent_at
    fill_in "Property ids", with: @matching_properties_email.property_ids
    click_on "Update Matching property email"

    assert_text "Matching property email was successfully updated"
    click_on "Back"
  end

  test "should destroy Matching property email" do
    visit matching_properties_email_url(@matching_properties_email)
    click_on "Destroy this matching property email", match: :first

    assert_text "Matching property email was successfully destroyed"
  end
end
