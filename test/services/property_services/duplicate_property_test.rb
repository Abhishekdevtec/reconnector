require 'test_helper'

module PropertyServices
  class DuplicatePropertyTest < ActiveSupport::TestCase
    include Devise::Test::IntegrationHelpers

    test 'should duplicate a property' do
      property_image_path = Rails.root.join('test', 'files', 'property_image_0.jpg')
      property = properties(:with_kitchen_sink)
      assert property.contract? # Make sure we duplicate with a contract
      assert property.contacts.any? # Make sure we duplicate with a contact

      # TODO: ActiveStorage variant creation is failing on the dev station?
      # property.images.attach(io: File.open(property_image_path), filename: 'property_image_0.jpg')
      # assert property.images.attached?

      duplicate_property_service = PropertyServices::DuplicateProperty.new.duplicate_property(property, property.agent)
      assert duplicate_property_service.duplicated?

      # Test property attributes
      duplicated_attributes.each do |key|
        assert_equal property.public_send(key), duplicate_property_service.property.public_send(key), "'#{key}' was not duplicated correctly"
      end
      rich_text_attributes.each do |key|
        assert_equal property.public_send(key).body, duplicate_property_service.property.public_send(key).body, "'#{key}' was not duplicated correctly"
      end
      assert_not_nil duplicate_property_service.property.internal_id
      assert_not_nil duplicate_property_service.property.calculated_building_area
      assert duplicate_property_service.property.calculated_building_area.positive?

      # test contacts
      assert duplicate_property_service.property.contacts.any?
      assert duplicate_property_service.property.contacts.count.positive?

      # test contract
      assert_not duplicate_property_service.property.contract.for_sale
      assert duplicate_property_service.property.contract.for_lease

      # test photos
      # TODO: ActiveStorage variant creation is failing on the dev station?
      # assert duplicate_property_service.property.images.attached?
      # assert duplicate_property_service.property.images.count.positive?
    end

    private

    def duplicated_attributes
      property = properties(:with_kitchen_sink)
      property.attributes.keys - ignored_attributes
    end

    def ignored_attributes
      %w(id internal_id created_at updated_at website_url calculated_building_area)
    end

    def rich_text_attributes
      %w(brochure_description fit_out furniture notes website_description)
    end
  end
end
