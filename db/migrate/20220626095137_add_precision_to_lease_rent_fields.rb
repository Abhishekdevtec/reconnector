class AddPrecisionToLeaseRentFields < ActiveRecord::Migration[7.0]
  def change
    add_column :contracts, :lease_net_rent,   :decimal, precision: 20, scale: 8
    add_column :contracts, :lease_gross_rent, :decimal, precision: 20, scale: 8
    add_column :contracts, :lease_outgoings,  :decimal, precision: 20, scale: 8

    # Move the values from the *_cents to the new decimal field,
    Contract.find_each do |contract|
      contract.update_columns(
        lease_net_rent: cents_to_decimal(contract.lease_net_rent_cents),
        lease_gross_rent: cents_to_decimal(contract.lease_gross_rent_cents),
        lease_outgoings: cents_to_decimal(contract.lease_outgoings_cents)
      )
    end
  end

  def cents_to_decimal(cents)
    cents.nil? ? nil : cents / 100.0
  end
end
