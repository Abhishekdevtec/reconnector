class AddContactDetailsToAccounts < ActiveRecord::Migration[7.0]
  def change
    add_column :accounts, :phone, :string, default: nil
    add_column :accounts, :email, :string, default: nil
    add_column :accounts, :fax, :string, default: nil
  end
end
