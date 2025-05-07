# frozen_string_literal: true
#
# Class which holds data
# from the 'province_state' table
module AquityV2
  class ProvinceState < Base
    attribute :id,                  :integer, default: nil
    attribute :country_id,          :integer, default: nil
    attribute :province_state_name, :string,  default: nil
    attribute :province_state_code, :string,  default: nil

    # Aassociations
    attr_accessor :country
  end
end
