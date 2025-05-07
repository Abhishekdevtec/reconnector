class AddMicrosoftGraphSupportToAccounts < ActiveRecord::Migration[7.0]
  def change
    add_column :accounts, :azure_application_id, :string, unique: true, default: nil, comment: 'This is generated when you register the application on Azure'
    add_column :accounts, :azure_tenant_id, :string, unique: true, default: nil, comment: 'This is generated when you register the application on Azure'
    add_column :accounts, :azure_encrypted_client_secret, :string, default: nil
    add_column :accounts, :enable_microsoft_graph_support, :boolean, default: false
  end
end
