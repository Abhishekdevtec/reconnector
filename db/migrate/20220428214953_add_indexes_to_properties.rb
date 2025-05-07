class AddIndexesToProperties < ActiveRecord::Migration[7.0]
  def change
    add_index :properties, :usages, using: 'gin'
  end
end
