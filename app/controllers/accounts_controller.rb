# frozen_string_literal: true

# No need to set/find @account since it is
# managed in ApplicationController
class AccountsController < ApplicationController
  before_action :authenticate_agent!
  before_action :verify_account_manager!

  # GET /accounts/1/edit
  def edit
    @selected_account_menu_option = :account
  end

  # PATCH/PUT /accounts/1 or /accounts/1.json
  def update
    if @account.update(account_params)
      redirect_to edit_account_path, notice: 'Account was successfully updated.'
    else
      redirect_to edit_account_path, alert: @account.errors.full_messages
    end
  end

  private

  # Only allow a list of trusted parameters through.
  def account_params
    params
      .require(:account)
      .permit(
        :azure_application_id,
        :azure_client_secret,
        :azure_tenant_id,
        :company_name,
        :domain_com_au_address_suggestions_api_key,
        :domain_com_au_agency_id,
        :domain_com_au_agents_and_listings_api_key,
        :domain_com_au_client_id,
        :domain_com_au_client_secret,
        :domain_com_au_listings_management_api_key,
        :domain_com_au_price_estimation_api_key,
        :domain_com_au_properties_and_locations_api_key,
        :domain_com_au_schools_data_api_key,
        :domain_com_au_webhooks_api_key,
        :domain_com_au_webhooks_id,
        :domain_com_au_webhooks_verification_code,
        :domain_name,
        :email,
        :enable_microsoft_graph_support,
        :ews_endpoint,
        :ews_synchronize,
        :fax,
        :griffin_property_com_au_api_token,
        :griffin_property_destination_folder,
        :griffin_property_host_url,
        :griffin_property_password,
        :griffin_property_username,
        :legal_name,
        :phone,
        :primary_color,
        :rea_client_id,
        :rea_client_secret,
        :rea_party_id,
        :secondary_color,
        # :rea_encrypted_password,
        # :rea_host,
        # :rea_username,
        addresses_attributes: %i[id line_1 line_2 line_3 city state country_id account_id],
        realestate_com_au_leads_api_attributes: [:id, :enabled, :account_id]
      )
  end
end
