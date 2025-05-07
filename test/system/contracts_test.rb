require "application_system_test_case"

class ContractsTest < ApplicationSystemTestCase
  setup do
    @contract = contracts(:one)
  end

  test "visiting the index" do
    visit contracts_url
    assert_selector "h1", text: "Contracts"
  end

  test "creating a Contract" do
    visit contracts_url
    click_on "New Contract"

    fill_in "Eoi close on", with: @contract.eoi_close_on
    fill_in "Eoi inspection on", with: @contract.eoi_inspection_on
    fill_in "Eoi minimum price cents", with: @contract.eoi_minimum_price_cents
    fill_in "Eoi target price cents", with: @contract.eoi_target_price_cents
    check "For lease" if @contract.for_lease
    check "For sale" if @contract.for_sale
    fill_in "Lease cleaning cents", with: @contract.lease_cleaning_cents
    fill_in "Lease commencement on", with: @contract.lease_commencement_on
    fill_in "Lease covered parking space cents", with: @contract.lease_covered_parking_space_cents
    fill_in "Lease escalation formulae", with: @contract.lease_escalation_formulae
    fill_in "Lease escalation rate", with: @contract.lease_escalation_rate
    fill_in "Lease expires on", with: @contract.lease_expires_on
    fill_in "Lease gross rent", with: @contract.lease_gross_rent
    fill_in "Lease net rent", with: @contract.lease_net_rent
    fill_in "Lease on grade parking space cents", with: @contract.lease_on_grade_parking_space_cents
    fill_in "Lease other rental costs cents", with: @contract.lease_other_rental_costs_cents
    fill_in "Lease outgoings", with: @contract.lease_outgoings
    fill_in "Lease rent review on", with: @contract.lease_rent_review_on
    fill_in "Lease term", with: @contract.lease_term
    fill_in "Private treaty minimum price cents", with: @contract.private_treaty_minimum_price_cents
    fill_in "Private treaty target price cents", with: @contract.private_treaty_target_price_cents
    fill_in "Property", with: @contract.property_id
    fill_in "Sale actual sale price cents", with: @contract.sale_actual_sale_price_cents
    fill_in "Sale auction venue", with: @contract.sale_auction_venue
    fill_in "Sale inspection on", with: @contract.sale_inspection_on
    fill_in "Sale price cents", with: @contract.sale_price_cents
    fill_in "Sale price from cents", with: @contract.sale_price_from_cents
    fill_in "Sale price to cents", with: @contract.sale_price_to_cents
    fill_in "Sale reserve price cents", with: @contract.sale_reserve_price_cents
    click_on "Create Contract"

    assert_text "Contract was successfully created"
    click_on "Back"
  end

  test "updating a Contract" do
    visit contracts_url
    click_on "Edit", match: :first

    fill_in "Eoi close on", with: @contract.eoi_close_on
    fill_in "Eoi inspection on", with: @contract.eoi_inspection_on
    fill_in "Eoi minimum price cents", with: @contract.eoi_minimum_price_cents
    fill_in "Eoi target price cents", with: @contract.eoi_target_price_cents
    check "For lease" if @contract.for_lease
    check "For sale" if @contract.for_sale
    fill_in "Lease cleaning cents", with: @contract.lease_cleaning_cents
    fill_in "Lease commencement on", with: @contract.lease_commencement_on
    fill_in "Lease covered parking space cents", with: @contract.lease_covered_parking_space_cents
    fill_in "Lease escalation formulae", with: @contract.lease_escalation_formulae
    fill_in "Lease escalation rate", with: @contract.lease_escalation_rate
    fill_in "Lease expires on", with: @contract.lease_expires_on
    fill_in "Lease gross rent", with: @contract.lease_gross_rent
    fill_in "Lease net rent cents", with: @contract.lease_net_rent_cents
    fill_in "Lease on grade parking space cents", with: @contract.lease_on_grade_parking_space_cents
    fill_in "Lease other rental costs cents", with: @contract.lease_other_rental_costs_cents
    fill_in "Lease outgoings", with: @contract.lease_outgoings
    fill_in "Lease rent review on", with: @contract.lease_rent_review_on
    fill_in "Lease term", with: @contract.lease_term
    fill_in "Private treaty minimum price cents", with: @contract.private_treaty_minimum_price_cents
    fill_in "Private treaty target price cents", with: @contract.private_treaty_target_price_cents
    fill_in "Property", with: @contract.property_id
    fill_in "Sale actual sale price cents", with: @contract.sale_actual_sale_price_cents
    fill_in "Sale auction venue", with: @contract.sale_auction_venue
    fill_in "Sale inspection on", with: @contract.sale_inspection_on
    fill_in "Sale price cents", with: @contract.sale_price_cents
    fill_in "Sale price from cents", with: @contract.sale_price_from_cents
    fill_in "Sale price to cents", with: @contract.sale_price_to_cents
    fill_in "Sale reserve price cents", with: @contract.sale_reserve_price_cents
    click_on "Update Contract"

    assert_text "Contract was successfully updated"
    click_on "Back"
  end

  test "destroying a Contract" do
    visit contracts_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Contract was successfully destroyed"
  end
end
