class CreateLocations < ActiveRecord::Migration[7.0]
  def change
    create_table :locations do |t|
      t.belongs_to :agent, null: false, foreign_key: true
      t.string :time_zone, default: 'UTC'

      t.timestamps
    end
  end
end
