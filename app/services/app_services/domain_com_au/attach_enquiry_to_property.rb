# frozen_string_literal: true

# Class which is part of the
# Domain.com API services
module AppServices
  module DomainComAu
    # Uses the Domain.com.au API to fetch an enquiry
    # and attach it to a property in Reconnector
    #
    # See https://developer.domain.com.au/docs/latest/apis/pkg_listing_management/references/enquiries_get/
    # and https://developer.domain.com.au/docs/latest/apis/pkg_webhooks/
    class AttachEnquiryToProperty
      include InboundWebhookable

      def initialize(account_id, enquiry_id, inbound_webhook_id = nil)
        @account_id = account_id
        @enquiry_id = enquiry_id
        @inbound_webhook_id = inbound_webhook_id
      end

      def attach_enquiry_to_property
        enquiry_response = client.get_enquiry(@enquiry_id)
        if enquiry_response.success?
          find_and_attach_enquiry_to_property(enquiry_response)
        else
          Rails.logger.info("[#{self.class}] ERROR Could not fetch enquiry. Got HTTP response #{enquiry_response.http_status}")
          Rails.logger.debug(enquiry_response.http_body)
          update_inbound_webhook_status(enquiry_response.success?)
        end
      end

      private

      def find_and_attach_enquiry_to_property(enquiry_response)
        Rails.logger.info("[#{self.class}] SUCCESS Fetched enquiry. Got HTTP response #{enquiry_response.http_status}")
        if can_attach_enquiry_to_property?(enquiry_response)
          property = Property.unscoped.find_by(domain_com_au_listing_id: enquiry_response.reference_id)
          property.listing_enquiries.create!(listing_enquiry_params(enquiry_response.http_body))
          update_inbound_webhook_status(true)
        else
          Rails.logger.error("[#{self.class}] ERROR Cannot find a matching property in Reconnector with domain_com_au_listing_id as '#{enquiry_response.reference_id}'")
          update_inbound_webhook_status(false)
        end
      rescue ActiveRecord::RecordInvalid => invalid
        Rails.logger.error("[#{self.class}] ERROR Cannot create ListingEnquiry with enquiry_response.http_body: '#{enquiry_response.http_body}'")
        Rails.logger.error(invalid.record.errors)
        update_inbound_webhook_status(false)
      end

      def listing_enquiry_params(enquiry_json)
        data = JSON.parse(enquiry_json, symbolize_names: true)
        {
          account_id: @account_id,
          property_portal: :commercial_real_estate,
          enquiry_id: data[:id],
          reference_id: data[:referenceId],
          sender_first_name: data[:sender][:firstName],
          sender_last_name: data[:sender][:lastName],
          sender_email: data[:sender][:email],
          sender_phone: data[:sender][:phoneNumber],
          message: data[:message],
          enquired_at: data[:recipientsDeliveryStatus].first[:date]
        }
      end

      def can_attach_enquiry_to_property?(enquiry_response)
        enquiry_response.enquiry_type == 'listing' && Property.where(domain_com_au_listing_id: enquiry_response.reference_id).exists?
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
