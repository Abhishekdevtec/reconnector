# frozen_string_literal: true
#
# Class which holds data
# from the 'property_type' table
module AquityV2
  class PropertyType < Base
    attribute :id,                 :integer, default: nil
    attribute :property_type_name, :string,  default: nil
  end
end
