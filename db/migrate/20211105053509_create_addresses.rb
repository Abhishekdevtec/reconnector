class CreateAddresses < ActiveRecord::Migration[6.1]
  def change
    create_table :addresses do |t|
      t.references :addressable, polymorphic: true
      t.integer :category, default: 0
      t.string :line_1
      t.string :line_2
      t.string :line_3
      t.string :city
      t.string :postal_code
      t.string :state
      t.string :country

      t.timestamps
    end
  end
end
