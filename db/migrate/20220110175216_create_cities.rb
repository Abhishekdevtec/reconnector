class CreateCities < ActiveRecord::Migration[6.1]
  def change
    create_table :cities do |t|
      t.belongs_to :state, null: false, foreign_key: true
      t.string :name
      t.string :postal_code

      t.timestamps
    end
  end
end
