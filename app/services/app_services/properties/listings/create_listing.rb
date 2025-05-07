# frozen_string_literal: true

module AppServices
  module Properties
    module Listings
      # Class which creates a listing on a property
      # portal.
      class CreateListing
        def create_listing(platform:, property_id:)
          if Property.exists?(property_id)
            @platform_job = "PropertyJobs::Listings::#{platform.to_s.camelcase}::CreateListingJob".constantize
            @platform_job.perform_later(property_id)
            true
          else
            false
          end
        end

        def create_listings(platform:, property_ids:)
          property_ids.each do |property_id|
            create_listing(platform: platform, property_id: property_id)
          end
        end
      end
    end
  end
end
