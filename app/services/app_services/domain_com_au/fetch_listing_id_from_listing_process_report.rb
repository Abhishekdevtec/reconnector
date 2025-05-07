# frozen_string_literal: true

module AppServices
  module DomainComAu
    # This class will poll the Domain.com.au API and
    # see if the property has an AdId (aka domain_com_au_listing_id).
    # If so, we update the property with the AdId.
    class FetchListingIdFromListingProcessReport
      include InboundWebhookable

      def initialize(process_report_id, inbound_webhook_id = nil)
        @process_report_id  = process_report_id
        @inbound_webhook_id = inbound_webhook_id
      end

      def fetch_listing_id
        if property_id.present?
          response = AppServices::DomainComAu::FetchListingAdId.new(property_id).fetch_listing_ad_id
          # Notify the inbound webhook if one was passed
          update_inbound_webhook_status(response.success?)
        else
          Rails.logger.error("[#{self.class}.fetch_listing_id] ERROR: Cannot find a property with a Domain.com.au process ID '#{@process_report_id}'. Will not fetch the processing report because there is no property to update.")
          update_inbound_webhook_status(false)
        end
      end

      private

      # Returns the Property.id or nil
      def property_id
        return portal_listing.property_id if portal_listing.present?

        nil
        # Property
        #   .unscoped
        #   .where(domain_com_au_process_id: @process_report_id)
        #   .pluck(:id)
        #   .first
      end

      def portal_listing
        @portal_listing ||= PortalListing::DomainComAu
                            .find_by(upload_id: @process_report_id)
      end
    end
  end
end
