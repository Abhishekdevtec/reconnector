# frozen_string_literal: true

# Class which is part of the
# Domain.com API services
module AppServices
  module DomainComAu
    # Save the listing ID (aka Ad Id) for a property
    # so that we can update and delete the property
    # on Domain.com.au
    class SetListingId
      def initialize(property_id, listing_id)
        @listing_id  = listing_id
        @property_id = property_id
      end

      def set_listing_id
        property.update_domain_com_au_listing_id(@listing_id)
      end

      private

      def property
        @property ||= Property.find(@property_id)
      rescue ActiveRecord::RecordNotFound
        Rails.logger.error "[#{self.class}] ERROR: Cannot find Property with ID #{@property_id}"
      end
    end
  end
end
