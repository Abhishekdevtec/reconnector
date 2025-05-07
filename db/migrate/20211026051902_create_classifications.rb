class CreateClassifications < ActiveRecord::Migration[6.1]
  def change
    create_table :classifications do |t|
      t.belongs_to :account, null: false, foreign_key: true
      t.references :classifiable, polymorphic: true
      t.string :name

      t.timestamps
    end
  end
end
