# == Schema Information
#
# Table name: contracts
#
#  created_at                         :datetime         not null
#  eoi_close_on                       :date
#  eoi_inspection_on                  :date
#  eoi_minimum_price_cents            :bigint
#  eoi_target_price_cents             :bigint
#  for_lease                          :boolean          default(FALSE)
#  for_sale                           :boolean          default(FALSE)
#  id                                 :bigint           not null, primary key
#  lease_cleaning_cents               :bigint
#  lease_commencement_on              :date
#  lease_covered_parking_space_cents  :bigint
#  lease_escalation_formulae          :string
#  lease_escalation_rate              :text
#  lease_expires_on                   :date
#  lease_gross_rent                   :decimal(20, 8)
#  lease_net_rent                     :decimal(20, 8)
#  lease_on_grade_parking_space_cents :bigint
#  lease_other_rental_costs_cents     :bigint
#  lease_outgoings                    :decimal(20, 8)
#  lease_rent_review_on               :date
#  lease_term                         :string
#  private_treaty_minimum_price_cents :bigint
#  private_treaty_target_price_cents  :bigint
#  property_id                        :bigint           not null
#  sale_actual_sale_price_cents       :bigint
#  sale_auction_date                  :date
#  sale_auction_venue                 :string
#  sale_inspection_on                 :date
#  sale_price_cents                   :bigint
#  sale_price_from_cents              :bigint
#  sale_price_to_cents                :bigint
#  sale_reserve_price_cents           :bigint
#  updated_at                         :datetime         not null
#
# Indexes
#
#  index_contracts_on_property_id  (property_id)
#
require "test_helper"

class ContractTest < ActiveSupport::TestCase
  context 'validations' do
    should belong_to :property
  end

  test 'contract should not be for_sale by default' do
    @property = properties(:industrial_property)
    contract = @property.build_contract
    assert_not contract.for_sale?
    assert_not contract.for_sale
  end

  test 'contract should not be for_lease by default' do
    @property = properties(:industrial_property)
    contract = @property.build_contract
    assert_not contract.for_lease?
    assert_not contract.for_lease
  end

  test 'should validate contract for_sale and/or for_lease' do
    @property = properties(:industrial_property)
    contract = @property.build_contract
    assert contract.invalid?

    contract.for_sale  = true
    contract.for_lease = false
    assert contract.valid?

    contract.for_sale  = false
    contract.for_lease = true
    assert contract.valid?

    contract.for_sale  = true
    contract.for_lease = true
    assert contract.valid?
  end
end
