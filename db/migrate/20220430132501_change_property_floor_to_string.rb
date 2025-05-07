class ChangePropertyFloorToString < ActiveRecord::Migration[7.0]
  def change
    change_column :properties, :floor, :string
  end
end
