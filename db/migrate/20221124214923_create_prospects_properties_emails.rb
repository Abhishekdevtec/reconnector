class CreateProspectsPropertiesEmails < ActiveRecord::Migration[7.0]
  def change
    create_table :prospects_properties_emails do |t|
      t.belongs_to :agent, null: false, foreign_key: true
      t.bigint :contact_ids, array: true
      t.bigint :property_ids, array: true
      t.boolean :attach_brochures, default: false
      t.datetime :sent_at
      t.datetime :created_at
    end
  end
end
