# frozen_string_literal: true

module PropertyServices
  class DuplicateProperty
    def duplicate_property(property, agent)
      ActiveRecord::Base.transaction do
        cloned_property = clone_property_with_associations(property)
        cloned_property.activity_logs.create(account: cloned_property.account, agent: agent, action: 'duplicated', result: 'success')
        Result.new(duplicated: true, property: cloned_property)
      rescue ActiveRecord::RecordInvalid
        Result.new(duplicated: false, property: cloned_property)
      end
    end

    # Our asynchronous job calls this method
    def after_duplicate(property)
      # any notifications that need to be sent?

      # Add to activity log
      property.activity_logs.create(account: property.account, agent: property.agent, action: 'created', result: 'success')
    end

    private

    def clone_property_with_associations(property)
      cloned_property = clone_property(property)
      cloned_property.save!

      if property.contract.present?
        cloned_contract = clone_property_contract(cloned_property, property.contract)
        cloned_contract.save!
      end

      # Clone contacts
      if property.contacts.any?
        property.contacts.each do |contact|
          PropertyContact.create!(property: cloned_property, contact: contact)
        end
      end

      # Clone the images
      if property.images.attached?
        property.images.each do |image|
          cloned_property.images.attach(image.blob)
        end
      end
      cloned_property
    end

    def clone_property(property)
      excluded_attributes = %w(id created_at updated_at internal_id rea_listing_id rea_listed domain_com_au domain_com_au_listing_id domain_com_au_listed domain_com_au_process_id website_url)
      rich_text_attributes = %w(brochure_description fit_out furniture notes website_description)
      attributes_to_clone = property.attributes.keys - excluded_attributes + rich_text_attributes
      cloned_property     = property.type.constantize.new
      attributes_to_clone.each { |a| cloned_property.public_send("#{a}=", property.public_send(a)) }
      cloned_property
    end

    def clone_property_contract(property, contract)
      excluded_attributes = %w(id created_at updated_at property_id)
      attributes_to_clone = contract.attributes.keys - excluded_attributes
      cloned_contract = property.build_contract
      attributes_to_clone.each { |a| cloned_contract[a] = contract[a] }
      cloned_contract
    end

    class Result
      attr_reader :property

      def initialize(duplicated:, property: nil)
        @duplicated = duplicated
        @property = property
      end

      def duplicated?
        @duplicated
      end
    end
  end
end
