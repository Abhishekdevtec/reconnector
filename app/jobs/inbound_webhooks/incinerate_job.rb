# frozen_string_literal: true

# Cleans up old webhooks which have been processed
# and who are older than 2 months
class InboundWebhooks::IncinerateJob < ApplicationJob
  DAYS_BEFORE_INCENERATION = 90

  queue_as :default

  def perform(*args)
    InboundWebhook.destroy_by(status: :processed, updated_at: ...DAYS_BEFORE_INCENERATION.days.ago)
  end
end
