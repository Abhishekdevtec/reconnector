# frozen_string_literal: true

module AquityV2Services
  module Builders
    module People
      def people
        @people ||= build_people
      end

      def find_person_by_id(id)
        people.select { |t| t.id == id }.first
      end

      def person_types
        @person_types ||= AquityV2::PersonType.from_table_data(data_table(:person_type))
      end

      def person_classifications
        @person_classifications ||= AquityV2::PersonClassification.from_table_data(data_table(:person_classification))
      end

      def find_person_classification_by_id(id)
        person_classifications.select { |pc| pc.id == id }.first
      end

      def person_classification_details
        @person_classification_details ||= AquityV2::PersonClassificationDetail.from_table_data(data_table(:person_classification_detail))
      end

      def find_person_type_by_id(id)
        person_types.select { |pt| pt.id == id }.first
      end

      def company_individuals
        @company_individuals ||= AquityV2::CompanyIndividual.from_table_data(data_table(:company_individual))
      end

      def find_company_individual_by_company_id(company_id)
        company_individuals.select { |p| p.company_id == company_id }.first
      end

      # Returns an array of AquityV2::PersonClassification
      # associated with the person_id
      def find_person_classifications_by_id(person_id)
        # Get an array of the person_classification IDs
        ids = person_classification_details.collect do |a|
          a.person_classification_id if a.person_id == person_id
        end
        person_classifications.select { |a| ids.compact.include?(a.id) }
      end

      private

      # Build an array of Aquity V2 Person
      # classes.
      # Associations are attached to each Person.
      def build_people
        arr = AquityV2::Person.from_table_data(data_table(:person))
        arr.each do |item|
          item.person_type            = find_person_type_by_id(item.person_type_id)
          item.pa_street_type         = find_street_type_by_id(item.pa_street_type_id)
          item.pa_suburb              = find_suburb_by_id(item.pa_suburb_id)
          item.pos_street_type        = find_street_type_by_id(item.pos_street_type_id)
          item.pos_suburb             = find_suburb_by_id(item.pos_suburb_id)
          item.creator                = find_user_by_id(item.created_by)
          item.person_classifications = find_person_classifications_by_id(item.id)
        end
        arr
      end
    end
  end
end
