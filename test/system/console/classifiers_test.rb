require "application_system_test_case"

class Console::ClassifiersTest < ApplicationSystemTestCase
  setup do
    @classifier = classifiers(:one)
  end

  test "visiting the index" do
    visit console_classifiers_url
    assert_selector "h1", text: "Console/Classifiers"
  end

  test "creating a Classifier" do
    visit console_classifiers_url
    click_on "New Console/Classifier"

    fill_in "Account", with: @classifier.account_id
    fill_in "Name", with: @classifier.name
    click_on "Create Classifier"

    assert_text "Classifier was successfully created"
    click_on "Back"
  end

  test "updating a Classifier" do
    visit console_classifiers_url
    click_on "Edit", match: :first

    fill_in "Account", with: @classifier.account_id
    fill_in "Name", with: @classifier.name
    click_on "Update Classifier"

    assert_text "Classifier was successfully updated"
    click_on "Back"
  end

  test "destroying a Classifier" do
    visit console_classifiers_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Classifier was successfully destroyed"
  end
end
