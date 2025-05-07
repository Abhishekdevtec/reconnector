# frozen_string_literal: true

# Class which removes a listing from a property
# portal.
module AppServices
  module Properties
    module Listings
      class DestroyListing
        def destroy_listing(platform:, property_id:)
          if Property.exists?(property_id)
            @platform_job = "PropertyJobs::Listings::#{platform.to_s.camelcase}::DestroyListingJob".constantize
            @platform_job.perform_later(property_id)
            true
          else
            false
          end
        end
      end
    end
  end
end
