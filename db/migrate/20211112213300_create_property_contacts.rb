class CreatePropertyContacts < ActiveRecord::Migration[6.1]
  def change
    create_table :property_contacts do |t|
      t.belongs_to :property, null: false, foreign_key: true
      t.belongs_to :contact, null: false, foreign_key: true

      t.timestamps
    end
  end
end
