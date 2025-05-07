class AddShareAttributeToProperties < ActiveRecord::Migration[7.0]
  def change
    add_column :properties, :share, :boolean, default: false
  end
end
