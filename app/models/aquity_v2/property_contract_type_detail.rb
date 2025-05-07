# frozen_string_literal: true
#
# Class which holds data
# from the 'property_contract_type_detail' table
module AquityV2
  class PropertyContractTypeDetail < Base
    attribute :id,                              :integer, default: nil
    attribute :property_id,                     :integer, default: nil
    attribute :contract_type_id,                :integer, default: nil
    attribute :sale_price,                      :float,   default: nil, precision: 12, scale: 2
    attribute :sale_price_from,                 :float,   default: nil, precision: 12,  scale: 2
    attribute :sale_price_to,                   :float,   default: nil, precision: 12,  scale: 2
    attribute :auction_date,                    :date,    default: nil
    attribute :auction_venue,                   :string,  default: nil
    attribute :inspection_date,                 :date,    default: nil
    attribute :reserve_price,                   :float,   default: nil, precision: 12, scale: 2
    attribute :actual_sale_price,               :float,   default: nil, precision: 12, scale: 2
    attribute :pt_min_price,                    :float,   default: nil, precision: 12, scale: 2
    attribute :pt_target_price,                 :float,   default: nil, precision: 12, scale: 2
    attribute :eoi_close_date,                  :date,    default: nil
    attribute :eoi_inspection_date,             :date,    default: nil
    attribute :eoi_min_price,                   :float,   default: nil, precision: 12, scale: 2
    attribute :eoi_target_price,                :float,   default: nil, precision: 12, scale: 2
    attribute :lease_unit_id,                   :integer, default: nil
    attribute :net_rent_per_area,               :decimal, default: nil, precision: 16, scale: 5
    attribute :net_rent_per_area_in_sq_meter,   :float,   default: nil, precision: 10, scale: 2
    attribute :total_net_rent,                  :float,   default: nil, precision: 50, scale: 2
    attribute :outgoings_per_area,              :decimal, default: nil, precision: 10, scale: 5
    attribute :outgoings_per_area_in_sq_meter,  :float,   default: nil, precision: 10, scale: 2
    attribute :total_outgoings,                 :float,   default: nil, precision: 10, scale: 2
    attribute :gross_rent_per_area,             :decimal, default: nil, precision: 10, scale: 2
    attribute :gross_rent_per_area_in_sq_meter, :float,   default: nil, precision: 10, scale: 2
    attribute :total_gross_rent,                :float,   default: nil, precision: 10, scale: 2
    attribute :cleaning_per_area,               :decimal, default: nil, precision: 10, scale: 5
    attribute :cleaning_per_area_in_sq_meter,   :float,   default: nil, precision: 10, scale: 2
    attribute :covered_parking_space_pa,        :float,   default: nil, precision: 10, scale: 2
    attribute :ongrade_parking_space_pa,        :float,   default: nil, precision: 10, scale: 2
    attribute :other_rental_cost,               :float,   default: nil, precision: 10, scale: 2
    attribute :lease_commencement,              :date,    default: nil
    attribute :lease_expiry,                    :date,    default: nil
    attribute :lease_terms,                     :string,  default: nil
    attribute :rent_review_date,                :date,    default: nil
    attribute :escalation_rate,                 :float,   default: nil, precision: 10, scale: 2
    attribute :escalation_formulae,             :string,  default: nil

    # Associations
    attr_accessor :contract_type

    def for_lease?
      contract_type&.contract_type_name&.include?('Lease')
    end

    def for_sale?
      contract_type&.contract_type_name&.include?('Sale')
    end
  end
end
