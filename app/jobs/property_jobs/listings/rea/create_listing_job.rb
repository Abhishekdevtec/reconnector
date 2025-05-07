# frozen_string_literal: true

module PropertyJobs
  module Listings
    module Rea
      class CreateListingJob < ApplicationJob
        def perform(property_id)
          handle_missing_property(property_id) unless Property.exists?(property_id)

          AppServices::Rea::CreateListing.new(property_id).create_listing
        end

        private

        def handle_missing_property(property_id)
          Rails.logger.error("[#{self.class}] ERROR Property #{property_id} does not exist.")
        end
      end
    end
  end
end
