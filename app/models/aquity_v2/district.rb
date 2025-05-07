# frozen_string_literal: true
#
# Class which holds data
# from the 'district' table
module AquityV2
  class District < Base
    attribute :id,                :integer, default: nil
    attribute :province_state_id, :integer, default: nil
    attribute :district_name,     :string,  default: nil

    # Associations
    attr_accessor :province_state
  end
end
