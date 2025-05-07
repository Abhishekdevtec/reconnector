class AddSuburbsToPropertyRequirements < ActiveRecord::Migration[7.0]
  def change
    add_column :property_requirements, :suburbs, :bigint, array: true, default: []
  end
end
