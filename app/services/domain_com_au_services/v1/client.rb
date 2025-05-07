# frozen_string_literal: true

# Low-level client class which is part of the
# Domain.com API services
#
# See https://developer.domain.com.au/docs/v1/getting-started
module DomainComAuServices
  module V1
    # Structure based on an super article
    # https://www.nopio.com/blog/how-to-create-an-api-wrapper-of-an-external-service-in-rails/
    class Client
      include HttpStatusCodes
      include ApiExceptions
      include Apis::ListingsManagement
      include Apis::Webhooks

      API_ENDPOINT = 'https://api.domain.com.au/'
      AUTHENTIFICATION_ENDPOINT = 'https://auth.domain.com.au/v1'

      attr_reader :oauth_token

      def initialize(oauth_token = nil)
        @oauth_token = oauth_token
      end

      # https://developer.domain.com.au/docs/v1/authentication/oauth/authorization-code-grant
      def authorization_code_grant_url(client_id:, redirect_uri:)
        params = {
          client_id: client_id,
          redirect_uri: redirect_uri,
          response_type: 'code',
          scope: authorization_scope,
          state: 'some_state'
        }
        uri = URI::HTTPS.build(host: 'auth.domain.com.au', path: '/v1/connect/authorize', query: params.to_query)
        uri.to_s
      end

      # https://developer.domain.com.au/docs/v1/authentication/oauth/authorization-code-grant
      def exchange_authorization_code_for_access_token(client_id:, client_secret:, authorization_code:, redirect_uri:)
        encoded_auth = encoded_authentification(client_id: client_id, client_secret: client_secret)
        body     = { grant_type: 'authorization_code', redirect_uri: redirect_uri, code: authorization_code }
        headers  = { 'Authorization': "Basic #{encoded_auth}", 'Content-Type': 'application/x-www-form-urlencoded' }
        response = authentication_client.post('connect/token', body, headers)
        manage_response(response)
      end

      # https://developer.domain.com.au/docs/v1/authentication/oauth/implicit-grant
      def authorization_implicit_grant(client_id:, redirect_uri:, scope:, nonce: nil)
        raise 'NotImplemented'
      end

      # https://developer.domain.com.au/docs/v1/authentication/oauth/refresh-tokens
      def refresh_token(client_id:, client_secret:, refresh_token:)
        raise NoRefreshToken if refresh_token.nil?

        encoded_auth = encoded_authentification(client_id: client_id, client_secret: client_secret)
        body     = { grant_type: 'refresh_token', refresh_token: refresh_token }
        headers  = { 'Authorization': "Basic #{encoded_auth}", 'Content-Type': 'application/x-www-form-urlencoded' }
        response = authentication_client.post('connect/token', body, headers)
        manage_response(response)
      end

      # https://developer.domain.com.au/docs/v1/authentication/oauth/revoking-tokens
      def revoke_token
        raise 'NotImplemented'
      end

      # https://developer.domain.com.au/docs/latest/apis/pkg_listing_management/references/listings_upsertcommerciallisting
      def create_commercial_listing(body)
        headers  = { 'Authorization': "Bearer #{@oauth_token}", 'Content-Type': 'application/json' }
        endpoint = if Rails.env.production?
                     'v1/listings/commercial'
                   else
                     'sandbox/v1/listings/commercial'
                   end
        request(http_method: :put, endpoint: endpoint, body: body, headers: headers)
      end

      private

      def authentication_client
        @authentication_client ||= Faraday.new(AUTHENTIFICATION_ENDPOINT) do |client|
          client.request :url_encoded
          client.adapter Faraday.default_adapter
          client.response :logger, Rails.logger, bodies: { request: true, response: true }
        end
      end

      def client
        @client ||= Faraday.new(API_ENDPOINT) do |client|
          client.request :url_encoded
          client.adapter Faraday.default_adapter
          client.headers['Authorization'] = "Bearer #{@oauth_token}" if @oauth_token.present?
          client.response :logger, Rails.logger, bodies: { request: true, response: true }
        end
      end

      def request(http_method:, endpoint:, headers: {}, params: {}, body: nil)
        case http_method
        when :get, :head, :delete, :trace
          response = client.public_send(http_method, endpoint, params, headers)
        when :post, :put, :patch
          response = client.public_send(http_method, endpoint, body, headers)
        end
        manage_response(response)
      end

      def manage_response(response)
        if response_successful?(response)
          OpenStruct.new(
            success?: true,
            code: response.status,
            body: response.body
          )
        else
        # parsed_response = JSON.parse(response.body) if response.body.length.positive?

        # return parsed_response if response_successful?(response)

          raise error_class(response), "code: #{response.status}, response: '#{response.body}'"
        end
      end

      def error_class(response)
        case response.status
        when HTTP_BAD_REQUEST_CODE
          BadRequestError
        when HTTP_UNAUTHORIZED_CODE
          UnauthorizedError
        when HTTP_FORBIDDEN_CODE
          # return ApiRequestsQuotaReachedError if api_requests_quota_reached?
          ForbiddenError
        when HTTP_PAGE_NOT_FOUND_CODE
          PageNotFoundError
        when HTTP_UNPROCESSABLE_ENTITY_CODE
          UnprocessableEntityError
        else
          ApiError
        end
      end

      def response_successful?(response)
        response.status == HTTP_OK_CODE || response.status == HTTP_ACCEPTED_CODE
      end

      def api_requests_quota_reached?(response)
        response.body.match?(API_REQUSTS_QUOTA_REACHED_MESSAGE)
      end

      def encoded_authentification(client_id:, client_secret:)
        Base64.strict_encode64("#{client_id}:#{client_secret}")
      end

      def authorization_scope
        if Rails.env.production?
          'openid profile offline_access api_agencies_read api_listings_read api_listings_write api_enquiries_read api_webhooks_write'
        else
          'openid profile offline_access api_agencies_read api_listings_read api_listings_write api_enquiries_read api_webhooks_write api_agencies_write'
        end
      end
    end
  end
end
