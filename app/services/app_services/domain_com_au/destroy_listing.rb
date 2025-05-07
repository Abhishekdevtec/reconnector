# frozen_string_literal: true

# Class which is part of the
# Domain.com API services
module AppServices
  module DomainComAu
    # Destroy a Listing from Domain.com.au using
    # their API
    #
    # See https://developer.domain.com.au/docs/latest/apis/pkg_listing_management/references/listings_updateoffmarketdetails
    class DestroyListing
      def initialize(property_id)
        @property_id = property_id
      end

      def destroy_listing()
        listing_id   = property.domain_com_au_listing_id
        access_token = property.account.domain_com_au_access_token
        client       = DomainComAuServices::V1::Client.new(access_token)
        response     = client.destroy_listing(listing_id, payload)
        Rails.logger.info response.inspect
        Rails.logger.info response.body

        if response.code.between?(200, 299)
          Rails.logger.info("[#{self.class}] SUCCESS Destroyed listing. Got HTTP response #{response.code}")
          Rails.logger.info(response&.body)
          property.update_column(:domain_com_au_listing_id, nil)
          property.update_column(:domain_com_au_listed, false)
          property.domain_com_au_listing.delete if property.domain_com_au_listing?
          property.activity_logs.create(account: property.account, agent: property.agent, action: 'deleted_domain_com_au_listing', result: 'success', payload: response.body)
        else
          handle_error(response)
        end
      rescue DomainComAuServices::V1::ApiExceptions::ApiExceptionError => e
        handle_exception(e)
      end

      private

      def property
        @property ||= Property.find(@property_id)
      end

      # https://developer.domain.com.au/docs/v1/apis/pkg_listing_management/references/listings_updateoffmarketdetails
      def payload
        {
          'offMarketAction': 'withDrawn',
          'actionDate': Date.today.strftime('%F')
        }.to_json
      end

      def handle_error(response)
        response_code = response&.code || nil
        Rails.logger.error("[#{self.class}] ERROR deleting listing. Got HTTP response #{response_code}")
        Rails.logger.error(response&.body)
        property.activity_logs.create(account: property.account, agent: property.agent, action: 'uploaded_domain_com_au_listing', result: 'failure', payload: response.body)
      end

      def handle_exception(e)
        Rails.logger.error("[#{self.class}] ERROR deleting listing. Got EXCEPTION response #{e}")
        Rails.logger.error(e.message)
        property.activity_logs.create(account: property.account, agent: property.agent, action: 'uploaded_domain_com_au_listing', result: 'exception', payload: e.message)
      end
    end
  end
end
