# frozen_string_literal: true
#
# Class which holds data
# from the 'street_type' table
module AquityV2
  class StreetType < Base
    attribute :id,               :integer, default: nil
    attribute :street_type_name, :string,  default: nil
  end
end
