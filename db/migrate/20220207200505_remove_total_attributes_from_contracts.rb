class RemoveTotalAttributesFromContracts < ActiveRecord::Migration[7.0]
  def change
    remove_column :contracts, :lease_total_net_rent_cents, :string
    remove_column :contracts, :lease_total_outgoings_cents, :string
    remove_column :contracts, :lease_total_gross_rent_cents, :string
  end
end
