class AddSynchronizeWithOfficeOnlineToContacts < ActiveRecord::Migration[7.0]
  def change
    add_column :contacts, :synchronize_with_office_online, :boolean, default: false
  end
end
