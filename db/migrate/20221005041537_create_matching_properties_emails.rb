class CreateMatchingPropertiesEmails < ActiveRecord::Migration[7.0]
  def change
    create_table :matching_properties_emails do |t|
      t.belongs_to :agent,            null: false, foreign_key: true
      t.belongs_to :contact,          null: false, foreign_key: true
      t.integer    :property_ids,     array: true
      t.boolean    :attach_brochures, default: false
      t.datetime   :email_sent_at,    default: nil
      t.datetime   :created_at
    end
  end
end
