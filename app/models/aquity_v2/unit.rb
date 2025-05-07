# frozen_string_literal: true
#
# Class which holds data
# from the 'unit' table
module AquityV2
  class Unit < Base
    attribute :id,                :integer, default: nil
    attribute :unit_name,         :string,  default: nil
    attribute :conversion_factor, :float,   default: nil
    attribute :unit_type_id,      :integer, default: nil

    # Associations
    attr_accessor :unit_type
  end
end
