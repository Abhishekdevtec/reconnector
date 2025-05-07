class AddExchangeWebServicesAttributes < ActiveRecord::Migration[7.0]
  def change
    # Add attributes to Accounts
    add_column :accounts, :ews_synchronize, :boolean, default: false
    add_column :accounts, :ews_endpoint,    :string,  default: nil

    # Add attributes to Agents
    add_column :agents, :ews_username,           :string, default: nil
    add_column :agents, :encrypted_ews_password, :string, default: nil

    # Add attributes to Contacts
    add_column :contacts, :ews_item_id,           :string,   default: nil
    add_column :contacts, :ews_change_key,        :string,   default: nil
    add_column :contacts, :ews_received_at,       :datetime, default: nil
    add_column :contacts, :ews_sent_at,           :datetime, default: nil
    add_column :contacts, :ews_created_at,        :datetime, default: nil
    add_column :contacts, :ews_last_modified_at,  :datetime, default: nil
    add_column :contacts, :ews_imported_from_ews, :boolean,  default: false
  end
end
