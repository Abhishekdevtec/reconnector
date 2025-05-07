class CreateDistricts < ActiveRecord::Migration[7.0]
  def change
    create_table :districts do |t|
      t.belongs_to :country, null: false, foreign_key: true
      t.string :name

      t.timestamps
    end
  end
end
