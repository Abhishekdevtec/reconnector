class CreateCountries < ActiveRecord::Migration[6.1]
  def change
    create_table :countries do |t|
      t.string :name, index: true, unique: true
      t.string :slug, index: true, unique: true
      t.string :country_code, unique: true

      t.timestamps
    end
  end
end
