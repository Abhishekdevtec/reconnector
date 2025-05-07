require 'test_helper'

module Microsoft
  module Graph
    module V1
      module Models
        class PhysicalAddressTest < ActiveSupport::TestCase
          test 'should return a valid hash' do
            expected_hash = { city: 'London', countryOrRegion: 'United Kingdom', postalCode: 'SW1A 1AA', state: 'London', street: '123 Fake Street' }
            physical_address = Microsoft::Graph::V1::Models::PhysicalAddress.new({ city: 'London', state: 'London', street: '123 Fake Street', postal_code: 'SW1A 1AA', country_or_region: 'United Kingdom' })
            assert_equal expected_hash.to_json, physical_address.to_h.to_json
          end

          test 'should return a valid hash even if some values are missing' do
            expected_hash = { city: 'London', postalCode: 'SW1A 1AA', state: 'London', street: '123 Fake Street' }
            physical_address = Microsoft::Graph::V1::Models::PhysicalAddress.new({ city: 'London', state: 'London', street: '123 Fake Street', postal_code: 'SW1A 1AA', country_or_region: '' })
            assert_equal expected_hash.to_json, physical_address.to_h.to_json
          end
        end
      end
    end
  end
end
