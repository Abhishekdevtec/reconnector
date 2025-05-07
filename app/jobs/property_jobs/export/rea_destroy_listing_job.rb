# frozen_string_literal: true

module PropertyJobs
  module Export
    class ReaDestroyListingJob < ApplicationJob
      def perform(property_id)
        property = Property.find(property_id)
      rescue ActiveRecord::RecordNotFound => e
        handle_missing_property(property_id, e)
      else
        PropertyServices::Export::ReaDestroyListing.new.destroy(property)
      end

      private

      def handle_missing_property(property_id, exception)
        Rails.logger.error("[PropertyJobs::Export::ReaDestroyListingJob(handle_missing_property)] ERROR loading property #{property_id}")
        Rails.logger.info(exception.message)
      end
    end
  end
end
