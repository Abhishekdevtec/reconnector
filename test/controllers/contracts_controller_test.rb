require 'test_helper'

class ContractsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @agent = agents(:bill)
    @property_without_contract = properties(:contractless)
    @property_with_contract = properties(:with_contract)
  end

  test 'should get new' do
    get new_property_contract_url(@property_without_contract)
    assert_redirected_to new_agent_session_url

    sign_in @agent
    get new_property_contract_url(@property_without_contract)
    assert_response :success
    assert_select 'h1', 'New contract'
    sign_out :agent
  end

  test 'should create contract' do
    @contract = contracts(:one)
    @property_without_contract.contract.delete if @property_without_contract.contract? # Just in case

    post property_contract_url(@property_without_contract), params: { contract: { eoi_close_on: @contract.eoi_close_on, eoi_inspection_on: @contract.eoi_inspection_on, eoi_minimum_price_cents: @contract.eoi_minimum_price_cents, eoi_target_price_cents: @contract.eoi_target_price_cents, for_lease: @contract.for_lease, for_sale: @contract.for_sale, lease_cleaning_cents: @contract.lease_cleaning_cents, lease_commencement_on: @contract.lease_commencement_on, lease_covered_parking_space_cents: @contract.lease_covered_parking_space_cents, lease_escalation_formulae: @contract.lease_escalation_formulae, lease_escalation_rate: @contract.lease_escalation_rate, lease_expires_on: @contract.lease_expires_on, lease_gross_rent: @contract.lease_gross_rent, lease_net_rent: @contract.lease_net_rent, lease_on_grade_parking_space_cents: @contract.lease_on_grade_parking_space_cents, lease_other_rental_costs_cents: @contract.lease_other_rental_costs_cents, lease_outgoings: @contract.lease_outgoings, lease_rent_review_on: @contract.lease_rent_review_on, lease_term: @contract.lease_term, private_treaty_minimum_price_cents: @contract.private_treaty_minimum_price_cents, private_treaty_target_price_cents: @contract.private_treaty_target_price_cents, property_id: @contract.property_id, sale_actual_sale_price_cents: @contract.sale_actual_sale_price_cents, sale_auction_venue: @contract.sale_auction_venue, sale_inspection_on: @contract.sale_inspection_on, sale_price_cents: @contract.sale_price_cents, sale_price_from_cents: @contract.sale_price_from_cents, sale_price_to_cents: @contract.sale_price_to_cents, sale_reserve_price_cents: @contract.sale_reserve_price_cents } }
    assert_redirected_to new_agent_session_url

    sign_in @agent
    assert_difference('Contract.count') do
      post property_contract_url(@property_without_contract), params: { contract: { eoi_close_on: @contract.eoi_close_on, eoi_inspection_on: @contract.eoi_inspection_on, eoi_minimum_price_cents: @contract.eoi_minimum_price_cents, eoi_target_price_cents: @contract.eoi_target_price_cents, for_lease: @contract.for_lease, for_sale: @contract.for_sale, lease_cleaning_cents: @contract.lease_cleaning_cents, lease_commencement_on: @contract.lease_commencement_on, lease_covered_parking_space_cents: @contract.lease_covered_parking_space_cents, lease_escalation_formulae: @contract.lease_escalation_formulae, lease_escalation_rate: @contract.lease_escalation_rate, lease_expires_on: @contract.lease_expires_on, lease_gross_rent: @contract.lease_gross_rent, lease_net_rent: @contract.lease_net_rent, lease_on_grade_parking_space_cents: @contract.lease_on_grade_parking_space_cents, lease_other_rental_costs_cents: @contract.lease_other_rental_costs_cents, lease_outgoings: @contract.lease_outgoings, lease_rent_review_on: @contract.lease_rent_review_on, lease_term: @contract.lease_term, private_treaty_minimum_price_cents: @contract.private_treaty_minimum_price_cents, private_treaty_target_price_cents: @contract.private_treaty_target_price_cents, property_id: @contract.property_id, sale_actual_sale_price_cents: @contract.sale_actual_sale_price_cents, sale_auction_venue: @contract.sale_auction_venue, sale_inspection_on: @contract.sale_inspection_on, sale_price_cents: @contract.sale_price_cents, sale_price_from_cents: @contract.sale_price_from_cents, sale_price_to_cents: @contract.sale_price_to_cents, sale_reserve_price_cents: @contract.sale_reserve_price_cents } }
    end
    assert_redirected_to @property_without_contract
    follow_redirect!
    assert_select 'h1', @property_without_contract.name
    sign_out :agent
  end

  test 'should show contract' do
    get property_contract_url(@property_with_contract)
    assert_redirected_to new_agent_session_url

    sign_in @agent
    get property_contract_url(@property_with_contract)
    assert_response :success
    assert_select 'h1', @property_with_contract.name

    get property_contract_url(@property_without_contract)
    assert_response :success
    assert_select 'h1', @property_without_contract.name
    sign_out :agent
  end

  test 'should get edit' do
    get edit_property_contract_url(@property_with_contract)
    assert_redirected_to new_agent_session_url

    sign_in @agent
    get edit_property_contract_url(@property_with_contract)
    assert_response :success
    sign_out :agent
  end

  test 'should update contract if it already exists' do
    contract = contracts(:updated_contract)

    patch property_contract_url(@property_with_contract), params: { contract: { eoi_close_on: contract.eoi_close_on, eoi_inspection_on: contract.eoi_inspection_on, eoi_minimum_price_cents: contract.eoi_minimum_price_cents, eoi_target_price_cents: contract.eoi_target_price_cents, for_lease: contract.for_lease, for_sale: contract.for_sale, lease_cleaning_cents: contract.lease_cleaning_cents, lease_commencement_on: contract.lease_commencement_on, lease_covered_parking_space_cents: contract.lease_covered_parking_space_cents, lease_escalation_formulae: contract.lease_escalation_formulae, lease_escalation_rate: contract.lease_escalation_rate, lease_expires_on: contract.lease_expires_on, lease_gross_rent: contract.lease_gross_rent, lease_net_rent: contract.lease_net_rent, lease_on_grade_parking_space_cents: contract.lease_on_grade_parking_space_cents, lease_other_rental_costs_cents: contract.lease_other_rental_costs_cents, lease_outgoings: contract.lease_outgoings, lease_rent_review_on: contract.lease_rent_review_on, lease_term: contract.lease_term, private_treaty_minimum_price_cents: contract.private_treaty_minimum_price_cents, private_treaty_target_price_cents: contract.private_treaty_target_price_cents, property_id: contract.property_id, sale_actual_sale_price_cents: contract.sale_actual_sale_price_cents, sale_auction_venue: contract.sale_auction_venue, sale_inspection_on: contract.sale_inspection_on, sale_price_cents: contract.sale_price_cents, sale_price_from_cents: contract.sale_price_from_cents, sale_price_to_cents: contract.sale_price_to_cents, sale_reserve_price_cents: contract.sale_reserve_price_cents } }
    assert_redirected_to new_agent_session_url

    sign_in @agent
    patch property_contract_url(@property_with_contract), params: { contract: { eoi_close_on: contract.eoi_close_on, eoi_inspection_on: contract.eoi_inspection_on, eoi_minimum_price_cents: contract.eoi_minimum_price_cents, eoi_target_price_cents: contract.eoi_target_price_cents, for_lease: contract.for_lease, for_sale: contract.for_sale, lease_cleaning_cents: contract.lease_cleaning_cents, lease_commencement_on: contract.lease_commencement_on, lease_covered_parking_space_cents: contract.lease_covered_parking_space_cents, lease_escalation_formulae: contract.lease_escalation_formulae, lease_escalation_rate: contract.lease_escalation_rate, lease_expires_on: contract.lease_expires_on, lease_gross_rent: contract.lease_gross_rent, lease_net_rent: contract.lease_net_rent, lease_on_grade_parking_space_cents: contract.lease_on_grade_parking_space_cents, lease_other_rental_costs_cents: contract.lease_other_rental_costs_cents, lease_outgoings: contract.lease_outgoings, lease_rent_review_on: contract.lease_rent_review_on, lease_term: contract.lease_term, private_treaty_minimum_price_cents: contract.private_treaty_minimum_price_cents, private_treaty_target_price_cents: contract.private_treaty_target_price_cents, property_id: contract.property_id, sale_actual_sale_price_cents: contract.sale_actual_sale_price_cents, sale_auction_venue: contract.sale_auction_venue, sale_inspection_on: contract.sale_inspection_on, sale_price_cents: contract.sale_price_cents, sale_price_from_cents: contract.sale_price_from_cents, sale_price_to_cents: contract.sale_price_to_cents, sale_reserve_price_cents: contract.sale_reserve_price_cents } }
    assert_redirected_to @property_with_contract
    sign_out :agent
  end

  test 'should destroy contract' do
    delete property_contract_url(@property_with_contract)
    assert_redirected_to new_agent_session_url

    sign_in @agent
    assert_difference('Contract.count', -1) do
      delete property_contract_url(@property_with_contract)
    end
    assert_redirected_to @property_with_contract
    sign_out :agent
  end
end
