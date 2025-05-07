class CreateActivityLogs < ActiveRecord::Migration[7.0]
  def change
    create_table :activity_logs do |t|
      t.belongs_to :account, null: false, foreign_key: true
      t.references :agent, foreign_key: true
      t.references :activityloggable, polymorphic: true, null: false
      t.string :action
      t.string :result
      t.string :body
      t.string :payload

      # t.timestamps
      t.datetime :created_at
    end
  end
end
