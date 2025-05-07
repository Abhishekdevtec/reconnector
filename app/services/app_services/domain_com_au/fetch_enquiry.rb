# frozen_string_literal: true

# Class which is part of the
# Domain.com API services
module AppServices
  module DomainComAu
    # Uses the Domain.com.au API to fetch an enquiry
    # and store it locally.
    #
    # See https://developer.domain.com.au/docs/latest/apis/pkg_listing_management/references/enquiries_get/
    # and https://developer.domain.com.au/docs/latest/apis/pkg_webhooks/
    class FetchEnquiry
      include InboundWebhookable

      def initialize(account_id, enquiry_id, inbound_webhook_id = nil)
        @account_id = account_id
        @enquiry_id = enquiry_id
        @inbound_webhook_id = inbound_webhook_id
      end

      def fetch_enquiry
        enquiry_response = client.get_enquiry(@enquiry_id)
        if enquiry_response.success?
          create_new_enquiry(enquiry_response)
        else
          Rails.logger.error("[#{self.class}] ERROR Could not fetch enquiry. Got HTTP response #{enquiry_response.http_status}")
          Rails.logger.debug(enquiry_response.http_body)
          update_inbound_webhook_status(enquiry_response.success?)
        end
      end

      private

      def create_new_enquiry(enquiry_response)
        Rails.logger.info("[#{self.class}] SUCCESS Fetched enquiry. Got HTTP response #{enquiry_response.http_status}")
        raw_listing_enquiry = RawListingEnquiry::DomainComAu.create(account_id: @account_id, body: JSON.parse(enquiry_response.http_body))
        if raw_listing_enquiry.persisted?
          Rails.logger.info("[#{self.class}] SUCCESS Created new enquiry (id: #{raw_listing_enquiry.id}))")
        else
          Rails.logger.error("[#{self.class}] ERROR Cannot create new RawListingEnquiry.")
          raw_listing_enquiry.errors.full_messages.each do |message|
            Rails.logger.info(message)
          end
        end
        update_inbound_webhook_status(raw_listing_enquiry.persisted?)
      end

      def account
        @account ||= Account.find(@account_id)
      end

      def access_token
        @access_token ||= account.domain_com_au_access_token
      end

      def client
        @client ||= DomainComAuServices::V1::Client.new(access_token)
      end
    end
  end
end
