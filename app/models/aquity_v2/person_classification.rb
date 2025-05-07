# frozen_string_literal: true
#
# Class which holds data
# from the 'person_classification' table
module AquityV2
  class PersonClassification < Base
    attribute :id,                  :integer, default: nil
    attribute :classification_name, :string,  default: nil
  end
end
