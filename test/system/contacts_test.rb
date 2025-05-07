require "application_system_test_case"

class ContactsTest < ApplicationSystemTestCase
  setup do
    @contact = contacts(:one)
  end

  test "visiting the index" do
    visit contacts_url
    assert_selector "h1", text: "Contacts"
  end

  test "creating a Contact" do
    visit contacts_url
    click_on "New Contact"

    fill_in "Account", with: @contact.account_id
    fill_in "Agent", with: @contact.agent_id
    fill_in "Business name", with: @contact.business_name
    fill_in "Email", with: @contact.email
    fill_in "Fax", with: @contact.fax
    fill_in "First name", with: @contact.first_name
    fill_in "Job title", with: @contact.job_title
    fill_in "Last name", with: @contact.last_name
    fill_in "Legal name", with: @contact.legal_name
    fill_in "Mobile", with: @contact.mobile
    fill_in "Notes", with: @contact.notes
    fill_in "Phone", with: @contact.phone
    fill_in "Registration", with: @contact.registration
    check "Share" if @contact.share
    fill_in "Type", with: @contact.type
    fill_in "Url", with: @contact.url
    click_on "Create Contact"

    assert_text "Contact was successfully created"
    click_on "Back"
  end

  test "updating a Contact" do
    visit contacts_url
    click_on "Edit", match: :first

    fill_in "Account", with: @contact.account_id
    fill_in "Agent", with: @contact.agent_id
    fill_in "Business name", with: @contact.business_name
    fill_in "Email", with: @contact.email
    fill_in "Fax", with: @contact.fax
    fill_in "First name", with: @contact.first_name
    fill_in "Job title", with: @contact.job_title
    fill_in "Last name", with: @contact.last_name
    fill_in "Legal name", with: @contact.legal_name
    fill_in "Mobile", with: @contact.mobile
    fill_in "Notes", with: @contact.notes
    fill_in "Phone", with: @contact.phone
    fill_in "Registration", with: @contact.registration
    check "Share" if @contact.share
    fill_in "Type", with: @contact.type
    fill_in "Url", with: @contact.url
    click_on "Update Contact"

    assert_text "Contact was successfully updated"
    click_on "Back"
  end

  test "destroying a Contact" do
    visit contacts_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Contact was successfully destroyed"
  end
end
