class CreateStates < ActiveRecord::Migration[6.1]
  def change
    create_table :states do |t|
      t.belongs_to :country, null: false, foreign_key: true
      t.string :name, index: true, unique: true
      t.string :abbreviation, index: true, unique: true

      t.timestamps
    end
  end
end
