class CreateContracts < ActiveRecord::Migration[6.1]
  def change
    create_table :contracts do |t|
      t.belongs_to :property, null: false, foreign_key: true
      t.boolean :for_sale, default: false
      t.boolean :for_lease, default: false
      t.bigint :sale_price_cents
      t.bigint :sale_price_from_cents
      t.bigint :sale_price_to_cents
      t.string :sale_auction_venue
      t.date :sale_auction_date
      t.date :sale_inspection_on
      t.bigint :sale_reserve_price_cents
      t.bigint :sale_actual_sale_price_cents
      t.bigint :private_treaty_minimum_price_cents
      t.bigint :private_treaty_target_price_cents
      t.date :eoi_close_on
      t.date :eoi_inspection_on
      t.bigint :eoi_minimum_price_cents
      t.bigint :eoi_target_price_cents
      t.bigint :lease_net_rent_cents
      t.bigint :lease_total_net_rent_cents
      t.bigint :lease_outgoings_cents
      t.bigint :lease_total_outgoings_cents
      t.bigint :lease_gross_rent_cents
      t.bigint :lease_total_gross_rent_cents
      t.bigint :lease_cleaning_cents
      t.bigint :lease_covered_parking_space_cents
      t.bigint :lease_on_grade_parking_space_cents
      t.bigint :lease_other_rental_costs_cents
      t.date :lease_commencement_on
      t.date :lease_expires_on
      t.string :lease_term
      t.date :lease_rent_review_on
      t.text :lease_escalation_rate
      t.string :lease_escalation_formulae

      t.timestamps
    end
  end
end
