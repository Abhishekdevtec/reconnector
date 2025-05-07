# frozen_string_literal: true

module Microsoft
  module Graph
    module V1
      module Auth
        AUTHENTIFICATION_HOST     = 'login.microsoftonline.com'
        AUTHENTIFICATION_ENDPOINT = "https://#{AUTHENTIFICATION_HOST}"
        AUTHORIZATION_SCOPE       = 'openid email offline_access mail.send contacts.readwrite'

        # See https://learn.microsoft.com/en-us/azure/active-directory/develop/v2-oauth2-auth-code-flow
        def authorization_code_grant_url(client_id:, tenant_id:, redirect_uri:)
          params = {
            client_id: client_id,
            response_type: 'code',
            redirect_uri: redirect_uri,
            reponse_mode: 'query',
            scope: AUTHORIZATION_SCOPE,
            state: 'some_state'
          }
          uri = URI::HTTPS.build(host: AUTHENTIFICATION_HOST, path: "/#{tenant_id}/oauth2/v2.0/authorize", query: params.to_query)
          uri.to_s
        end

        # See https://learn.microsoft.com/en-us/azure/active-directory/develop/v2-oauth2-auth-code-flow#request-an-access-token-with-a-client_secret
        def exchange_authorization_code_for_access_token(client_id:, tenant_id:, client_secret:, authorization_code:, redirect_uri:)
          path     = "#{tenant_id}/oauth2/v2.0/token"
          body     = { client_id: client_id, scope: AUTHORIZATION_SCOPE, grant_type: 'authorization_code', redirect_uri: redirect_uri, code: authorization_code, client_secret: client_secret }
          headers  = { 'Content-Type': 'application/x-www-form-urlencoded' }
          response = authentication_client.post(path, body, headers)
          if response.status == 200 or response.status == 202
            OpenStruct.new(success?: true, error?: false, status: response.status, body: JSON.parse(response.body))
          else
            OpenStruct.new(success?: false, error?: true, status: response.status, body: JSON.parse(response.body))
          end
        end

        def refresh_access_token(client_id:, tenant_id:, client_secret:, refresh_token:)
          path     = "#{tenant_id}/oauth2/v2.0/token"
          body     = { client_id: client_id, scope: AUTHORIZATION_SCOPE, grant_type: 'refresh_token', refresh_token: refresh_token, client_secret: client_secret }
          headers  = { 'Content-Type': 'application/x-www-form-urlencoded' }
          response = authentication_client.post(path, body, headers)
          if response.status == 200 or response.status == 202
            OpenStruct.new(success?: true, error?: false, status: response.status, body: JSON.parse(response.body))
          else
            OpenStruct.new(success?: false, error?: true, status: response.status, body: JSON.parse(response.body))
          end
        end

        private

        def authentication_client
          @authentication_client ||= Faraday.new(AUTHENTIFICATION_ENDPOINT) do |client|
            client.request :url_encoded
            client.adapter Faraday.default_adapter
            client.response :logger, Rails.logger, bodies: { request: true, response: true }
          end
        end
      end
    end
  end
end
