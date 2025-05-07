class AddGriffinPropertyListingSupport < ActiveRecord::Migration[7.0]
  def change
    add_column :accounts, :griffin_property_host_url,           :string, default: nil
    add_column :accounts, :griffin_property_username,           :string, default: nil
    add_column :accounts, :griffin_property_encrypted_password, :string, default: nil
    add_column :accounts, :griffin_property_destination_folder, :string, default: nil
  end
end
