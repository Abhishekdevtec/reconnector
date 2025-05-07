# frozen_string_literal: true

module AppServices
  module Rea
    class ListingClient
      def initialize(property_id)
        @property_id = property_id
      end

      private

      def property
        @property ||= Property.find(@property_id)
      end

      def account
        @account ||= property.account
      end

      def rea_client
        @rea_client ||= ReaServices::V1::Client.new
      end

      def access_token
        response = rea_client.get_access_token(client_id, client_secret)
        return JSON.parse(response.body)['access_token'] if response.success?

        Rails.logger.error("[#{self.class}] ERROR, cannot get RealEstate.com.au access token. HTTP error code #{response.code}")
        Rails.logger.error(response.body)
      end

      # Must be overridden by subclasses
      def payload
        raise 'NotImplementedError', 'You must override this method in a subclass.'
      end

      def client_id
        account.rea_client_id
      end

      def client_secret
        account.rea_client_secret
      end

      def add_error_to_activity_log(property, result)
        property.activity_logs.create(
          account: property.account,
          agent: property.agent,
          action: 'uploaded_rea_listing',
          result: 'failure',
          payload: result.response,
          body: result.response
        )
      end
    end
  end
end
