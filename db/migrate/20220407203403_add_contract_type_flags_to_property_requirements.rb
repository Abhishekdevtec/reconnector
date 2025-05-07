class AddContractTypeFlagsToPropertyRequirements < ActiveRecord::Migration[7.0]
  def change
    add_column :property_requirements, :for_sale, :boolean, default: false
    add_column :property_requirements, :for_lease, :boolean, default: false

    PropertyRequirement.where(contract_type: 'Sale').update_all(for_sale: true)
    PropertyRequirement.where(contract_type: 'Lease').update_all(for_lease: true)
    PropertyRequirement.where(contract_type: 'Sale & Lease').update_all(for_lease: true, for_sale: true)
  end
end
