class AddDomainComAuCredentialsToAccount < ActiveRecord::Migration[7.0]
  def change
    # Authorization attributes
    add_column :accounts, :domain_com_au_encrypted_authorization_code, :string,   default: nil
    add_column :accounts, :domain_com_au_encrypted_access_token,       :string,   default: nil
    add_column :accounts, :domain_com_au_access_token_expires_at,      :datetime, default: nil
    add_column :accounts, :domain_com_au_access_token_type,            :string,   default: nil
    add_column :accounts, :domain_com_au_encrypted_refresh_token,      :string,   default: nil

    # API attributes
    add_column :accounts, :domain_com_au_client_id,                        :string, default: nil
    add_column :accounts, :domain_com_au_encrypted_client_secret,          :string, default: nil
    add_column :accounts, :domain_com_au_agents_and_listings_api_key,      :string, default: nil
    add_column :accounts, :domain_com_au_properties_and_locations_api_key, :string, default: nil
    add_column :accounts, :domain_com_au_price_estimation_api_key,         :string, default: nil
    add_column :accounts, :domain_com_au_address_suggestions_api_key,      :string, default: nil
    add_column :accounts, :domain_com_au_schools_data_api_key,             :string, default: nil
    add_column :accounts, :domain_com_au_listings_management_api_key,      :string, default: nil
    add_column :accounts, :domain_com_au_webhooks_api_key,                 :string, default: nil
  end
end
