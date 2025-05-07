class CreateAccessRequests < ActiveRecord::Migration[7.0]
  def change
    create_table :access_requests do |t|
      t.string :first_name
      t.string :last_name
      t.string :company
      t.string :agent_count
      t.string :email
      t.string :phone
      t.text :request

      t.timestamps
    end
  end
end
