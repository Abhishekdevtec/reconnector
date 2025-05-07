class AddDistrictToPropertyRequirements < ActiveRecord::Migration[7.0]
  def change
    add_reference :property_requirements, :district, index: true, null: true, foreign_key: true
  end
end
