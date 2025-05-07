class AddReaAccountDetailsToAccount < ActiveRecord::Migration[6.1]
  def change
    add_column :accounts, :rea_host, :string, default: nil
    add_column :accounts, :rea_username, :string, default: nil
    add_column :accounts, :rea_encrypted_password, :string, default: nil
  end
end
