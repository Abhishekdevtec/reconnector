class AddCalculatedBuildingAreaToProperties < ActiveRecord::Migration[7.0]
  def change
    # add_column :properties, :calculated_building_area, :virtual, type: :decimal, as: 'office_area + warehouse_area + showroom_area + storage_area + production_area + trading_area + floor_area', stored: true
    add_column :properties, :calculated_building_area, :decimal, default: nil
  end
end
