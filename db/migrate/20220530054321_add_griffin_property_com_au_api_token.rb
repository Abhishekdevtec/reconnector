class AddGriffinPropertyComAuApiToken < ActiveRecord::Migration[7.0]
  def change
    add_column :accounts, :encrypted_griffin_property_com_au_api_token, :string, default: nil
  end
end
