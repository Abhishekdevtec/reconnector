require 'test_helper'

module Microsoft
  module Graph
    module V1
      module Models
        class ContactTest < ActiveSupport::TestCase
          test 'should return a valid hash' do
            expected_hash = { assistantName: 'Dorothy', birthday: '1980-03-28T00:00:00+01:00', businessAddress: { city: 'Sydney', countryOrRegion: 'Australia' }, businessHomePage: 'https://domain.com', businessPhones: ['0123456789'], categories: ['manager', 'prospect'], companyName: 'Big Inc.', department: 'Property Aquisition', displayName: 'John Doe', emailAddresses: [{ address: 'john.doe@domain.com', name: 'John Doe' }], generation: 'Jr.', givenName: 'John', homeAddress: { city: 'London', countryOrRegion: 'UK' }, homePhones: ['0123456789'], jobTitle: 'Big boss', mobilePhone: '0123456789', nickName: 'Johnny', officeLocation: 'London', otherAddress: { city: 'London', countryOrRegion: 'UK' }, personalNotes: 'Some notes', profession: 'Big boss', surname: 'Doe', title: 'Mr.' }
            contact = Microsoft::Graph::V1::Models::Contact.new({ assistant_name: 'Dorothy', birthday: Date.new(1980, 3, 28).to_s, business_address: { city: 'Sydney', country_or_region: 'Australia' }, business_home_page: 'https://domain.com', business_phones: ['0123456789'], categories: ['manager', 'prospect'], company_name: 'Big Inc.', department: 'Property Aquisition', display_name: 'John Doe', email_addresses: [{ name: 'John Doe', address: 'john.doe@domain.com' }], generation: 'Jr.', given_name: 'John', home_address: { city: 'London', country_or_region: 'UK' }, home_phones: ['0123456789'], job_title: 'Big boss', mobile_phone: '0123456789', nick_name: 'Johnny', office_location: 'London', other_address: { city: 'London', country_or_region: 'UK' }, personal_notes: 'Some notes', profession: 'Big boss', surname: 'Doe', title: 'Mr.' })
            assert_equal expected_hash.to_json, contact.to_h.to_json
          end

          # test 'should return a valid hash even if some values are missing' do
          #   expected_hash = { city: 'London', postalCode: 'SW1A 1AA', state: 'London', street: '123 Fake Street' }
          #   contact = Microsoft::Graph::V1::Models::Contact.new({ city: 'London', state: 'London', street: '123 Fake Street', postal_code: 'SW1A 1AA', country_or_region: '' })
          #   assert_equal expected_hash.to_json, contact.to_h.to_json
          # end
        end
      end
    end
  end
end
