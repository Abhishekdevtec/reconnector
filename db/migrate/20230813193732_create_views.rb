class CreateViews < ActiveRecord::Migration[7.0]
  def change
    create_table :views do |t|
      t.references :viewable, polymorphic: true, null: false
      t.datetime   :viewed_at
      t.references :viewed_by, null: false, foreign_key: { to_table: :agents }
      t.datetime   :created_at, null: false
    end
  end
end
