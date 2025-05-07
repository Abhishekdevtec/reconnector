# frozen_string_literal: true

# Class which is part of the
# Domain.com API services
module AppServices
  module DomainComAu
    # Create a Listing from Domain.com.au using
    # their API
    #
    # See https://developer.domain.com.au/docs/latest/apis/pkg_listing_management/references/listings_updateoffmarketdetails
    class CreateListing
      def initialize(property_id)
        @property_id = property_id
      end

      def create_listing
        payload      = DomainComAuServices::V1::Models::Listing.create(property).as_json
        response     = create_commercial_listing(payload)

        return unless response.success?

        processing_id = response.id
        property.update_column(:domain_com_au_process_id, processing_id)
        property.create_domain_com_au_listing(upload_id: processing_id)

        # Now we need to get the status of the process
        ::DomainComAu::FetchListingIdJob.perform_later(@property_id)
      end

      private

      def property
        @property ||= Property.find(@property_id)
      end

      def access_token
        @access_token ||= property.account.domain_com_au_access_token
      end

      def client
        @client ||= DomainComAuServices::V1::Client.new(access_token)
      end

      def create_commercial_listing(payload)
        response = client.create_commercial_listing(payload)

        if response.success?
          Rails.logger.info("[#{self.class}] SUCCESS Uploaded listing. Got HTTP response #{response.code}")
          Rails.logger.debug(response&.body)
          property.activity_logs.create(account: property.account, agent: property.agent, action: 'uploaded_domain_com_au_listing', result: 'success', payload: response.body)
          build_response_from_body(response.body)
        else
          Rails.logger.info("[#{self.class}] ERROR Uploaded listing. Got HTTP response #{response.code}")
          Rails.logger.debug(response&.body)
          property.activity_logs.create(account: property.account, agent: property.agent, action: 'uploaded_domain_com_au_listing', result: 'failure', payload: response.body)
          OpenStruct.new(success?: false)
        end
      rescue DomainComAuServices::V1::ApiExceptions::ApiExceptionError => e
        Rails.logger.info("[#{self.class}] API Error while uploading listing.")
        Rails.logger.info(e.message)
        property.activity_logs.create(account: property.account, agent: property.agent, action: 'uploaded_domain_com_au_listing', result: 'failure', payload: e.message)
        OpenStruct.new(success?: false)
      end

      # See https://developer.domain.com.au/docs/v1/apis/pkg_listing_management/references/listings_upsertcommerciallisting
      # for the full details on the response given when uploading a listing
      def build_response_from_body(body)
        json = JSON.parse(body)
        OpenStruct.new(
          success?: true,
          process_status: json['processStatus'],
          id: json['id'],
          agency_id: json['agencyId'],
          provider_id: json['providerId'],
          provider_ad_id: json['providerAdId'],
          version_id: json['versionId']
        )
      end
    end
  end
end
