# frozen_string_literal: true

module Microsoft
  module Graph
    module V1
      # Microsoft Graph V1 Client
      class Client
        include Exceptions
        include Apis
        include Auth

        API_ENDPOINT = 'https://graph.microsoft.com/v1.0/'

        def initialize(oauth_token = nil)
          @oauth_token = oauth_token
        end

        private

        def client
          @client ||= Faraday.new(API_ENDPOINT) do |client|
            client.request :url_encoded
            client.adapter Faraday.default_adapter
            client.headers['Authorization'] = "Bearer #{@oauth_token}" if @oauth_token.present?
            client.response :logger, Rails.logger, bodies: { request: true, response: true }
          end
        end
      end
    end
  end
end
