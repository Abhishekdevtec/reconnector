# frozen_string_literal: true
#
# Class which holds data
# from the 'person_classification_detail' table
#
# The 'person_classification_detail' table seems
# to be a link table between a 'person' and a
# 'person_classification'
module AquityV2
  class PersonClassificationDetail < Base
    attribute :person_id,                :integer, default: nil
    attribute :person_classification_id, :integer, default: nil
  end
end
