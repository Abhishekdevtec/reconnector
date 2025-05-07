# frozen_string_literal: true

module Agents
  # Mangages OAuth sign-in for Microsoft Graph
  class MicrosoftGraphSessionsController < ApplicationController
    before_action :authenticate_agent!

    def new
      redirect_to microsoft_graph_url, allow_other_host: true
    end

    private

    def microsoft_graph_url
      Microsoft::Graph::V1::Client.new.authorization_code_grant_url(client_id: client_id, tenant_id: tenant_id, redirect_uri: callback_url)
    end

    def client_id
      @account.azure_application_id
    end

    def tenant_id
      @account.azure_tenant_id
    end

    def callback_url
      new_agent_microsoft_graph_auth_url
    end
  end
end
