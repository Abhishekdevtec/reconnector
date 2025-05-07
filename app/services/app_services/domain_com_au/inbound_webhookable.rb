# frozen_string_literal: true

module AppServices
  module DomainComAu
    module InboundWebhookable
      def update_inbound_webhook_status(success)
        inbound_webhook(@inbound_webhook_id).update_processed_status(success) if inbound_webhook_present?
      end

      def inbound_webhook_present?
        return false if @inbound_webhook_id.blank?
        return false unless InboundWebhook.exists?(@inbound_webhook_id)

        true
      end

      def inbound_webhook(id)
        InboundWebhook.find(id)
      rescue ActiveRecord::RecordNotFound
        Rails.logger.error("[#{self.class}] ERROR finding InboundWebhook #{id}")
      end
    end
  end
end
