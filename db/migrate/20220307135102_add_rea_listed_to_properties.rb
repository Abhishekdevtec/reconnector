class AddReaListedToProperties < ActiveRecord::Migration[7.0]
  def change
    add_column :properties, :rea_listed, :boolean, default: false
  end
end
