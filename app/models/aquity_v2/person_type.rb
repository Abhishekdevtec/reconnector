# frozen_string_literal: true
#
# Class which holds data
# from the 'person_type' table
module AquityV2
  class PersonType < Base
    attribute :id,               :integer, default: nil
    attribute :person_type_name, :string,  default: nil

    def individual?
      person_type_name.downcase == 'individual'
    end

    def company?
      person_type_name.downcase == 'company'
    end
  end
end
