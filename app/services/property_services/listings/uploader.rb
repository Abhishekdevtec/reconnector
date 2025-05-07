# frozen_string_literal: true

module PropertyServices
  module Listings
    class Uploader
      def initialize(platform:, property_id:)
        @platform = "PropertyServices::Listings::#{platform.to_s.camelcase}::Uploader".constantize
        @property_id = property_id
      end

      def upload_listing
        @platform.new.upload_listing(@property_id)
      end
    end
  end
end
