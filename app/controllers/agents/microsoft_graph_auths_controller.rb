# frozen_string_literal: true

module Agents
  # Mangages OAuth sign-in for Microsoft Graph
  class MicrosoftGraphAuthsController < ApplicationController
    before_action :authenticate_agent!

    # GET /agent/microsoft_graph_auth/new
    def new
      # Check for errors
      # See https://learn.microsoft.com/en-us/azure/active-directory/develop/v2-oauth2-auth-code-flow
      if error?
        Rails.logger.info params.inspect
        redirect_to edit_agent_path, alert: 'An error occured while trying to login. Please try again.'
      else
        authorization_code = params[:code]
        # Get an access token
        response = authentication_client.exchange_authorization_code_for_access_token(client_id: @account.azure_application_id, tenant_id: @account.azure_tenant_id, client_secret: @account.azure_client_secret, authorization_code: authorization_code, redirect_uri: new_agent_microsoft_graph_auth_url)
        if response.error?
          Rails.logger.info response.body.inspect
          redirect_to edit_agent_path, alert: 'An error occured while trying to get an access token. Please try again.'
        else
          # Save the access token
          Rails.logger.info response.body.inspect
          @current_agent.build_or_update_microsoft_graph_token(response.body)
          redirect_to edit_agent_path, notice: 'Got access token!'
        end
      end
    end

    private

    def error?
      params[:error].present?
    end

    def authentication_client
      @authentication_client ||= Microsoft::Graph::V1::Client.new
    end
  end
end
