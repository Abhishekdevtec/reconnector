require "test_helper"

module Console
  class ContractsControllerTest < ActionDispatch::IntegrationTest
    include Devise::Test::IntegrationHelpers

    setup do
      @overlord = overlords(:one)
      @account = accounts(:one)
      @property_without_contract = properties(:contractless)
      @property_with_contract = properties(:with_contract)
    end

    test "should get new" do
      get new_console_account_property_contract_url(@account, @property_with_contract)
      assert_redirected_to new_overlord_session_path

      sign_in @overlord
      get new_console_account_property_contract_url(@account, @property_with_contract)
      assert_response :success
      sign_out :overlord
    end

    test "should create contract" do
      @contract = contracts(:one)
      @property_without_contract.contract.delete if @property_without_contract.contract?

      post console_account_property_contract_url(@account, @property_without_contract), params: { contract: { eoi_close_on: @contract.eoi_close_on, eoi_inspection_on: @contract.eoi_inspection_on, eoi_minimum_price_cents: @contract.eoi_minimum_price_cents, eoi_target_price_cents: @contract.eoi_target_price_cents, for_lease: @contract.for_lease, for_sale: @contract.for_sale, lease_cleaning_cents: @contract.lease_cleaning_cents, lease_commencement_on: @contract.lease_commencement_on, lease_covered_parking_space_cents: @contract.lease_covered_parking_space_cents, lease_escalation_formulae: @contract.lease_escalation_formulae, lease_escalation_rate: @contract.lease_escalation_rate, lease_expires_on: @contract.lease_expires_on, lease_gross_rent: @contract.lease_gross_rent, lease_net_rent: @contract.lease_net_rent, lease_on_grade_parking_space_cents: @contract.lease_on_grade_parking_space_cents, lease_other_rental_costs_cents: @contract.lease_other_rental_costs_cents, lease_outgoings: @contract.lease_outgoings, lease_rent_review_on: @contract.lease_rent_review_on, lease_term: @contract.lease_term, private_treaty_minimum_price_cents: @contract.private_treaty_minimum_price_cents, private_treaty_target_price_cents: @contract.private_treaty_target_price_cents, property_id: @contract.property_id, sale_actual_sale_price_cents: @contract.sale_actual_sale_price_cents, sale_auction_venue: @contract.sale_auction_venue, sale_inspection_on: @contract.sale_inspection_on, sale_price_cents: @contract.sale_price_cents, sale_price_from_cents: @contract.sale_price_from_cents, sale_price_to_cents: @contract.sale_price_to_cents, sale_reserve_price_cents: @contract.sale_reserve_price_cents } }
      assert_redirected_to new_overlord_session_path

      sign_in @overlord
      assert_difference('Contract.count') do
        post console_account_property_contract_url(@account, @property_without_contract), params: { contract: { eoi_close_on: @contract.eoi_close_on, eoi_inspection_on: @contract.eoi_inspection_on, eoi_minimum_price_cents: @contract.eoi_minimum_price_cents, eoi_target_price_cents: @contract.eoi_target_price_cents, for_lease: @contract.for_lease, for_sale: @contract.for_sale, lease_cleaning_cents: @contract.lease_cleaning_cents, lease_commencement_on: @contract.lease_commencement_on, lease_covered_parking_space_cents: @contract.lease_covered_parking_space_cents, lease_escalation_formulae: @contract.lease_escalation_formulae, lease_escalation_rate: @contract.lease_escalation_rate, lease_expires_on: @contract.lease_expires_on, lease_gross_rent: @contract.lease_gross_rent, lease_net_rent: @contract.lease_net_rent, lease_on_grade_parking_space_cents: @contract.lease_on_grade_parking_space_cents, lease_other_rental_costs_cents: @contract.lease_other_rental_costs_cents, lease_outgoings: @contract.lease_outgoings, lease_rent_review_on: @contract.lease_rent_review_on, lease_term: @contract.lease_term, private_treaty_minimum_price_cents: @contract.private_treaty_minimum_price_cents, private_treaty_target_price_cents: @contract.private_treaty_target_price_cents, property_id: @contract.property_id, sale_actual_sale_price_cents: @contract.sale_actual_sale_price_cents, sale_auction_venue: @contract.sale_auction_venue, sale_inspection_on: @contract.sale_inspection_on, sale_price_cents: @contract.sale_price_cents, sale_price_from_cents: @contract.sale_price_from_cents, sale_price_to_cents: @contract.sale_price_to_cents, sale_reserve_price_cents: @contract.sale_reserve_price_cents } }
      end
      assert_redirected_to [:console, @account, @property_without_contract]
      sign_out :overlord
    end

    test "should show contract" do
      get console_account_property_contract_url(@account, @property_with_contract)
      assert_redirected_to new_overlord_session_path

      sign_in @overlord
      get console_account_property_contract_url(@account, @property_with_contract)
      assert_response :success
      sign_out :overlord
    end

    test "should get edit" do
      get edit_console_account_property_contract_url(@account, @property_with_contract)
      assert_redirected_to new_overlord_session_path

      sign_in @overlord
      get edit_console_account_property_contract_url(@account, @property_with_contract)
      assert_response :success
      sign_out :overlord
    end

    test "should update contract" do
      @contract = contracts(:updated_contract)
      patch console_account_property_contract_url(@account, @property_with_contract), params: { contract: { eoi_close_on: @contract.eoi_close_on, eoi_inspection_on: @contract.eoi_inspection_on, eoi_minimum_price_cents: @contract.eoi_minimum_price_cents, eoi_target_price_cents: @contract.eoi_target_price_cents, for_lease: @contract.for_lease, for_sale: @contract.for_sale, lease_cleaning_cents: @contract.lease_cleaning_cents, lease_commencement_on: @contract.lease_commencement_on, lease_covered_parking_space_cents: @contract.lease_covered_parking_space_cents, lease_escalation_formulae: @contract.lease_escalation_formulae, lease_escalation_rate: @contract.lease_escalation_rate, lease_expires_on: @contract.lease_expires_on, lease_gross_rent: @contract.lease_gross_rent, lease_net_rent: @contract.lease_net_rent, lease_on_grade_parking_space_cents: @contract.lease_on_grade_parking_space_cents, lease_other_rental_costs_cents: @contract.lease_other_rental_costs_cents, lease_outgoings: @contract.lease_outgoings, lease_rent_review_on: @contract.lease_rent_review_on, lease_term: @contract.lease_term, private_treaty_minimum_price_cents: @contract.private_treaty_minimum_price_cents, private_treaty_target_price_cents: @contract.private_treaty_target_price_cents, property_id: @contract.property_id, sale_actual_sale_price_cents: @contract.sale_actual_sale_price_cents, sale_auction_venue: @contract.sale_auction_venue, sale_inspection_on: @contract.sale_inspection_on, sale_price_cents: @contract.sale_price_cents, sale_price_from_cents: @contract.sale_price_from_cents, sale_price_to_cents: @contract.sale_price_to_cents, sale_reserve_price_cents: @contract.sale_reserve_price_cents } }
      assert_redirected_to new_overlord_session_path

      sign_in @overlord
      patch console_account_property_contract_url(@account, @property_with_contract), params: { contract: { eoi_close_on: @contract.eoi_close_on, eoi_inspection_on: @contract.eoi_inspection_on, eoi_minimum_price_cents: @contract.eoi_minimum_price_cents, eoi_target_price_cents: @contract.eoi_target_price_cents, for_lease: @contract.for_lease, for_sale: @contract.for_sale, lease_cleaning_cents: @contract.lease_cleaning_cents, lease_commencement_on: @contract.lease_commencement_on, lease_covered_parking_space_cents: @contract.lease_covered_parking_space_cents, lease_escalation_formulae: @contract.lease_escalation_formulae, lease_escalation_rate: @contract.lease_escalation_rate, lease_expires_on: @contract.lease_expires_on, lease_gross_rent: @contract.lease_gross_rent, lease_net_rent: @contract.lease_net_rent, lease_on_grade_parking_space_cents: @contract.lease_on_grade_parking_space_cents, lease_other_rental_costs_cents: @contract.lease_other_rental_costs_cents, lease_outgoings: @contract.lease_outgoings, lease_rent_review_on: @contract.lease_rent_review_on, lease_term: @contract.lease_term, private_treaty_minimum_price_cents: @contract.private_treaty_minimum_price_cents, private_treaty_target_price_cents: @contract.private_treaty_target_price_cents, property_id: @contract.property_id, sale_actual_sale_price_cents: @contract.sale_actual_sale_price_cents, sale_auction_venue: @contract.sale_auction_venue, sale_inspection_on: @contract.sale_inspection_on, sale_price_cents: @contract.sale_price_cents, sale_price_from_cents: @contract.sale_price_from_cents, sale_price_to_cents: @contract.sale_price_to_cents, sale_reserve_price_cents: @contract.sale_reserve_price_cents } }
      assert_redirected_to [:console, @account, @property_with_contract]
      sign_out :overlord
    end

    test "should destroy contract" do
      delete console_account_property_contract_url(@account, @property_with_contract)
      assert_redirected_to new_overlord_session_path

      sign_in @overlord
      assert_difference('Contract.count', -1) do
        delete console_account_property_contract_url(@account, @property_with_contract)
      end
      assert_redirected_to [:console, @account, @property_with_contract]
      sign_out :overlord
    end
  end
end
