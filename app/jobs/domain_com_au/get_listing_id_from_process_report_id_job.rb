# frozen_string_literal: true

# Job which gets the property "ad_id" or property_id
# from Domain.com.au. The property ID is generated once
# the property has been uploaded to Domain AND processed.
module DomainComAu
  # This class will poll the Domain.com.au API and
  # see if the property has an AdId.
  #
  # https://developer.domain.com.au/docs/v1/apis/pkg_listing_management/references/listings_getlistingreport
  class GetListingIdFromProcessReportIdJob < ApplicationJob
    queue_as :default

    retry_on AppServices::DomainComAu::FetchListingAdId::UnprocessedListingError, wait: 2.minutes, attempts: 5

    def perform(process_id, inbound_webhook_id = nil)
      Rails.logger.info("[#{self.class}.perform] called with process_id: #{process_id}")

      property_id = Property.unscoped.find_by!(domain_com_au_process_id: process_id)
      response = AppServices::DomainComAu::FetchListingAdId.new(property_id).fetch_listing_ad_id

      # Notify the inbound webhook if one was passed
      update_inbound_webhook_status(inbound_webhook_id, response.success?) if inbound_webhook_id.present?
    rescue ActiveRecord::RecordNotFound
      Rails.logger.error("[#{self.class}.perform] ERROR: Cannot find a property with a Domain.com.au process ID '#{process_id}'")
    end

    private

    def update_inbound_webhook_status(inbound_webhook_id, success)
      inbound_webhook(inbound_webhook_id).update_processed_status(success) if inbound_webhook_id.present?
    end

    def inbound_webhook(id)
      InboundWebhook.find(id)
    rescue ActiveRecord::RecordNotFound
      Rails.logger.error("[#{self.class}] ERROR finding InboundWebhook #{id}")
    end
  end
end
