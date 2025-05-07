# frozen_string_literal: true

module AppServices
  module Microsoft
    module Graph
      # Class which refresh an access token over on
      # Microsoft Graph
      # See https://learn.microsoft.com/en-us/azure/active-directory/develop/v2-oauth2-auth-code-flow#refresh-the-access-token
      class RefreshAccessToken
        def initialize(agent)
          @agent         = agent
          @client_id     = @agent.account.azure_application_id
          @tenant_id     = @agent.account.azure_tenant_id
          # @client_secret = @agent.account.azure_client_secret 
          @client_secret = @agent.account.azure_encrypted_client_secret
        end

        def refresh_access_token
          response = @client.refresh_access_token(client_id: @client_id, tenant_id: @tenant_id, client_secret: @client_secret, refresh_token: @agent.microsoft_graph_token.refresh_token)
          if response.error?
            Rails.logger.error "[#{self.class}] ERROR trying to refresh token for #{@agent.name}"
          else
            @agent.build_or_update_microsoft_graph_token(response.body)
          end
        end

        private

        def client
          @client ||= ::Microsoft::Graph::V1::Client.new
        end
      end
    end
  end
end
