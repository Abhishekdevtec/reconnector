# frozen_string_literal: true

# Class which is part of the
# Domain.com API services
module AppServices
  module DomainComAu
    # For a listing that is currently being processed
    # by Domain.com.au, the AdId is not known until
    # the listing has been processed.
    #
    # This class will poll the Domain.com.au API and
    # see if the property has an AdId.
    #
    # https://developer.domain.com.au/docs/v1/apis/pkg_listing_management/references/listings_getlistingreport
    class FetchListingAdId
      class UnprocessedListingError < StandardError; end

      def initialize(property_id)
        @property_id = property_id
      end

      def fetch_listing_ad_id
        response = client.get_processing_report(process_id)
        Rails.logger.info response.inspect
        Rails.logger.info response.http_status
        Rails.logger.info response.http_body

        if response.success?
          handle_response(response)
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

      def process_id
        @process_id ||= property.domain_com_au_process_id
      end

      def access_token
        @access_token ||= property.account.domain_com_au_access_token
      end

      def client
        @client ||= DomainComAuServices::V1::Client.new(access_token)
      end

      def handle_response(response)
        Rails.logger.info("[#{self.class}] SUCCESS Got listing Ad ID. Got HTTP response #{response.http_status}")
        Rails.logger.info(response.http_status)
        Rails.logger.info(response.http_body)
        Rails.logger.info(response.process_status)
        Rails.logger.info(response.ad_id)

        # The listing has not been processed yet so we raise an error
        # which should be picked up by the caller (job) and
        # a several retries should be attempted.
        raise UnprocessedListingError unless listing_processed?(response.process_status)

        if response.ad_id.present?
          property.update_domain_com_au_listing_id(response.ad_id)
          property.activity_logs.create(account: property.account, agent: property.agent, action: 'domain_com_au_get_listing_ad_id', result: 'success', payload: response.http_body)
        else
          property.activity_logs.create(account: property.account, agent: property.agent, action: 'domain_com_au_get_listing_ad_id', result: 'warning', payload: response.http_body)
        end
        OpenStruct.new(success?: response.ad_id.present?, listing_id: response.ad_id, process_status: response.process_status)
      end

      def handle_error(response)
        response_code = response&.http_status || nil
        Rails.logger.error("[#{self.class}] ERROR getting process. Got HTTP response #{response_code}")
        Rails.logger.error(response&.http_body)
        property.activity_logs.create(account: property.account, agent: property.agent, action: 'domain_com_au_get_listing_ad_id', result: 'failure', payload: response.http_body)
        OpenStruct.new(success?: false, error: "[#{self.class}] ERROR getting process with id #{process_id}", payload: response.http_body)
      end

      def handle_exception(e)
        Rails.logger.error("[#{self.class}] ERROR getting process. Got EXCEPTION response #{e}")
        Rails.logger.error(e.message)
        property.activity_logs.create(account: property.account, agent: property.agent, action: 'domain_com_au_get_listing_ad_id', result: 'exception', payload: e.message)
        OpenStruct.new(success?: false, error: "[#{self.class}] EXCEPTION getting process with id #{process_id}", exception: e.message)
      end

      def listing_processed?(process_status)
        %i[processed searchable failed error].include?(process_status)
      end
    end
  end
end
