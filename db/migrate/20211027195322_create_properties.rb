class CreateProperties < ActiveRecord::Migration[6.1]
  def change
    create_table :properties do |t|
      t.string :type, index: true
      t.belongs_to :agent, null: false, foreign_key: true
      t.string :internal_id, index: true
      t.string :usages, array: true, default: []
      t.string :unique_space
      t.string :floor_level
      t.string :name
      t.string :building
      t.string :naming_rights
      t.integer :naming_rights_cost_cents
      t.string :estate
      t.string :suite
      t.string :floor
      t.string :street_number
      t.string :street_name
      t.string :state
      t.string :city
      t.string :postal_code
      t.string :country
      t.string :local_council
      t.decimal :office_area, precision: 10, scale: 2
      t.decimal :warehouse_area, precision: 10, scale: 2
      t.decimal :showroom_area, precision: 10, scale: 2
      t.decimal :storage_area, precision: 10, scale: 2
      t.decimal :production_area, precision: 10, scale: 2
      t.decimal :trading_area, precision: 10, scale: 2
      t.decimal :floor_area, precision: 10, scale: 2
      t.decimal :land_area, precision: 10, scale: 2
      t.decimal :hard_stand_yard_area, precision: 10, scale: 2
      t.string :land_area_description # TO DO: Add to model, forms, etc.
      t.string :hard_stand_yard_description # TO DO: Add to model, forms, etc.
      t.string :headline
      t.string :grabline
      t.string :keywords
      t.text :description
      t.text :features
      t.integer :parking_spaces
      t.string :parking_comments
      t.text :fit_out
      t.text :furniture
      t.string :lifts_escalators_travelators
      t.decimal :min_clearance_height, precision: 10, scale: 2
      t.decimal :max_clearance_height, precision: 10, scale: 2
      t.string :clear_span_columns
      t.string :lot_number
      t.string :crane
      t.string :entrances_roller_doors_container_access
      t.string :zoning
      t.string :disability_access
      t.string :rating
      t.text :notes

      t.timestamps
    end
  end
end
