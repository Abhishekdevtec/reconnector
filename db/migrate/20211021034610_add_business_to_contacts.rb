class AddBusinessToContacts < ActiveRecord::Migration[6.1]
  def change
    add_reference :contacts, :business, null: true, index: true, foreign_key: { to_table: :contacts }
  end
end
