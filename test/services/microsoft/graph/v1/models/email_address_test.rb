require 'test_helper'

module Microsoft
  module Graph
    module V1
      module Models
        class EmailAddressTest < ActiveSupport::TestCase
          test 'should return a valid hash' do
            expected_hash = { address: 'john.doe@unknown.com', name: 'John Doe' }
            email_address = Microsoft::Graph::V1::Models::EmailAddress.new({ name: 'John Doe', address: 'john.doe@unknown.com' })
            assert_equal expected_hash.to_json, email_address.to_h.to_json
          end

          test 'should return a valid hash even if some values are missing' do
            expected_hash = { address: 'john.doe@unknown.com' }
            email_address = Microsoft::Graph::V1::Models::EmailAddress.new({ name: '', address: 'john.doe@unknown.com' })
            assert_equal expected_hash.to_json, email_address.to_h.to_json
          end
        end
      end
    end
  end
end
