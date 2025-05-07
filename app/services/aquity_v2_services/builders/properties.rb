# frozen_string_literal: true

module AquityV2Services
  module Builders
    module Properties
      include Builders::Units
      include Builders::People

      def properties
        @properties ||= build_properties
      end

      def find_property_by_id(id)
        properties.select { |p| p.id == id }.first
      end

      def property_descriptions
        @property_descriptions ||= build_property_descriptions
      end

      def find_property_description_by_property_id(property_id)
        property_descriptions.select { |p| p.property_id == property_id }.first
      end

      def property_usages
        @property_usages ||= AquityV2::PropertyUsage.from_table_data(data_table(:property_usage))
      end

      def find_property_usage_by_id(id)
        property_usages.select { |p| p.id == id }.first
      end

      def property_types
        @property_types ||= AquityV2::PropertyType.from_table_data(data_table(:property_type))
      end

      def find_property_type_by_id(id)
        property_types.select { |p| p.id == id }.first
      end

      def property_contract_type_details
        @property_contract_type_details ||= build_property_contract_type_details
      end

      def find_property_contract_type_detail_by_property_id(property_id)
        property_contract_type_details.select { |p| p.property_id == property_id }.first
      end

      def contract_types
        @contract_types ||= AquityV2::ContractType.from_table_data(data_table(:contract_type))
      end

      def find_contract_type_by_id(id)
        contract_types.select { |p| p.id == id }.first
      end

      def property_people
        @property_people ||= build_property_people
      end

      # Returns an array of AquityV2::PropertyPerson
      # associated with the property_id
      def find_property_people_by_property_id(property_id)
        property_people.select { |p| p.property_id == property_id }
      end

      # Returns an array of AquityV2::PersonClassifications
      # from the 'property_person' table using the following
      # attributes as the unique key:
      # property_id, person_type, company_id and person_id
      def find_property_people_classifications_for_property_person_type_company_person(property_id, person_type_id, company_id, person_id)
        property_people.select do |p|
          p.property_id == property_id &&
            p.person_type_id == person_type_id &&
            p.company_id == company_id &&
            p.person_id == person_id
        end
      end

      # Get a list of 'property_person' entries
      # without the person_classification_ids
      def select_unique_property_person_type_company_persons_from_property_person
        objs = []
        property_people.each do |property_person|
          obj = {}
          obj['property_id'] = property_person.property_id
          obj['person_type_id'] = property_person.person_type_id
          obj['company_id'] = property_person.company_id
          obj['person_id'] = property_person.person_id
          objs << obj
        end
        property_people.uniq { |p| [p.album_id, p.author_id] }
      end

      def property_images
        @property_images ||= AquityV2::PropertyImage.from_table_data(data_table(:property_image))
      end

      def find_property_images_by_property_id(property_id)
        property_images.select { |p| p.property_id == property_id }
      end

      def person_property_requirements
        @person_property_requirements ||= build_person_property_requirements
      end

      private

      def build_properties
        arr = AquityV2::Property.from_table_data(data_table(:property))
        arr.each do |item|
          item.user                 = find_user_by_id(item.user_id)
          item.creator              = find_user_by_id(item.created_by)
          item.suburb               = find_suburb_by_id(item.suburb_id)
          item.district             = find_district_by_id(item.district_id)
          item.province_state       = find_province_state_by_id(item.province_state_id)
          item.country              = find_country_by_id(item.country_id)
          item.property_description = find_property_description_by_property_id(item.id)
          item.contract             = find_property_contract_type_detail_by_property_id(item.id)
          item.contacts             = build_contacts_by_property_id(item.id)
          # item.images               = find_property_images_by_property_id(item.id)
        end
        arr
      end

      def build_property_descriptions
        arr = AquityV2::PropertyDescription.from_table_data(data_table(:property_description))
        arr.each do |item|
          item.property_type  = find_property_type_by_id(item.property_type_id)
          item.property_usage = find_property_usage_by_id(item.property_usage_id)
          item.area_unit      = find_unit_by_id(item.area_unit_id)
          item.clearence_unit = find_unit_by_id(item.clearence_unit_id)
        end
        arr
      end

      def build_property_contract_type_details
        arr = AquityV2::PropertyContractTypeDetail.from_table_data(data_table(:property_contract_type_detail))
        arr.each do |item|
          item.contract_type = find_contract_type_by_id(item.contract_type_id)
        end
        arr
      end

      def build_property_people
        arr = AquityV2::PropertyPerson.from_table_data(data_table(:property_person))
        arr.each do |item|
          item.person_type = find_person_type_by_id(item.person_type_id)
          item.company = find_person_by_id(item.company_id)
          item.person = find_person_by_id(item.person_id)
          item.person_classification = find_person_classification_by_id(item.person_classification_id)
        end
        arr
      end

      def build_contacts_by_property_id(property_id)
        all_property_people = property_people.select { |o| o.property_id == property_id }
        return nil if all_property_people.empty?

        unique_property_contacts = all_property_people.uniq do |pc|
          [pc.property_id, pc.person_type_id, pc.company_id, pc.person_id]
        end

        property_contacts = []

        unique_property_contacts.each do |unique_contact|
          # Get an array of the person_classification IDs
          ids = all_property_people.collect do |a|
            a.person_classification_id if a.property_id == unique_contact.property_id &&
                                            a.person_type_id == unique_contact.person_type_id &&
                                            a.company_id == unique_contact.company_id &&
                                            a.person_id == unique_contact.person_id
          end
          classifications = person_classifications.collect { |a| a.classification_name if ids.compact.include?(a.id) }.reject(&:blank?)
          property_contacts << OpenStruct.new(
            property_id: unique_contact.property_id,
            person_type_id: unique_contact.person_type_id,
            person_type: find_person_type_by_id(unique_contact.person_type_id),
            company_id: unique_contact.company_id,
            company: find_person_by_id(unique_contact.company_id),
            person_id: unique_contact.person_id,
            person: find_person_by_id(unique_contact.person_id),
            classifications: classifications
          )
        end
        property_contacts
      end

      def build_person_property_requirements
        arr = AquityV2::PersonPropertyRequirement.from_table_data(data_table(:person_property_requirement))
        arr.each do |item|
          item.contract_type = find_contract_type_by_id(item.contract_type_id)
          item.property_type = find_property_type_by_id(item.property_type_id)
        end
        arr
      end
    end
  end
end
