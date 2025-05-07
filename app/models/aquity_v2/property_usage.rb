# frozen_string_literal: true
#
# Class which holds data
# from the 'property_usage' table
module AquityV2
  class PropertyUsage < Base
    attribute :id,                  :integer, default: nil
    attribute :property_usage_name, :string,  default: nil
  end
end
