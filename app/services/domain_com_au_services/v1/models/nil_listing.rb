# frozen_string_literal: true

# See https://developer.domain.com.au/docs/v1/getting-started
module DomainComAuServices
  module V1
    module Models
      # Nil property model used by the Listing factory.
      class NilListing
        def initialize(property)
        end

        def as_json
          raise 'NotImplemented'
        end
      end
    end
  end
end
