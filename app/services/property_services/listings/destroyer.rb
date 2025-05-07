# frozen_string_literal: true

module PropertyServices
  module Listings
    class Destroyer
      def initialize(platform:, property_id:)
        @platform = "PropertyServices::Listings::#{platform.to_s.camelcase}::Destroyer".constantize
        @property_id = property_id
      end

      def destroy_listing
        @platform.new.destroy_listing(@property_id)
      end
    end
  end
end
