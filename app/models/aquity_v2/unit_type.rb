# frozen_string_literal: true
#
# Class which holds data
# from the 'unit_type' table
module AquityV2
  class UnitType < Base
    attribute :id,             :integer, default: nil
    attribute :unit_type_name, :string,  default: nil
  end
end
