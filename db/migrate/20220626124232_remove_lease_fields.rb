class RemoveLeaseFields < ActiveRecord::Migration[7.0]
  def change
    remove_column :contracts, :lease_net_rent_cents
    remove_column :contracts, :lease_outgoings_cents
    remove_column :contracts, :lease_gross_rent_cents
  end
end
