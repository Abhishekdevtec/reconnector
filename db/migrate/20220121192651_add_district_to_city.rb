class AddDistrictToCity < ActiveRecord::Migration[7.0]
  def change
    add_reference :cities, :district, null: true, foreign_key: true
  end
end
