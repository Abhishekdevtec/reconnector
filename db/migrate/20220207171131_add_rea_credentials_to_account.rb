class AddReaCredentialsToAccount < ActiveRecord::Migration[7.0]
  def change
    add_column :accounts, :rea_party_id, :string, default: nil
    add_column :accounts, :rea_client_id, :string, default: nil
    add_column :accounts, :rea_encrypted_client_secret, :string, default: nil
  end
end
