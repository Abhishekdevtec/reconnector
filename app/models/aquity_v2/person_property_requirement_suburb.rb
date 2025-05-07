# frozen_string_literal: true
#
# Class which holds data
# from the 'person_property_requirement_suburb' table
#
# The 'person_classification_detail' table seems
# to be a link table between a 'property_requirement'
# and a 'suburb'
module AquityV2
  class PersonPropertyRequirementSuburb < Base
    attribute :propreq_id, :integer, default: nil
    attribute :suburb_id,  :integer, default: nil
  end
end
