class CreateProspectNotificationEmails < ActiveRecord::Migration[7.0]
  def change
    create_table :prospect_notification_emails do |t|
      t.belongs_to :contact, null: false, foreign_key: true
      t.belongs_to :property, null: false, foreign_key: true
      t.datetime :emailed_at
    end
  end
end
