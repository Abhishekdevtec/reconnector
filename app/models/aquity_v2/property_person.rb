# frozen_string_literal: true
#
# Class which holds data
# from the 'property_person' table
module AquityV2
  class PropertyPerson < Base
    attribute :property_id,              :integer, default: nil
    attribute :person_type_id,           :integer, default: nil
    attribute :company_id,               :integer, default: nil
    attribute :person_id,                :integer, default: nil
    attribute :person_classification_id, :integer, default: nil

    # Associations
    attr_accessor :person_type, :company, :person, :person_classification
  end
end
