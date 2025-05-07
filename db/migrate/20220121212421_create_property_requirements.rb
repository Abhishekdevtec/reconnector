class CreatePropertyRequirements < ActiveRecord::Migration[7.0]
  def change
    create_table :property_requirements do |t|
      t.belongs_to :contact, null: false, foreign_key: true
      t.string :property_type
      t.string :contract_type
      t.decimal :area_from, precision: 10, scale: 2
      t.decimal :area_to, precision: 10, scale: 2
      t.integer :price_from_cents
      t.integer :price_to_cents
      t.boolean :active

      t.timestamps
    end
  end
end
