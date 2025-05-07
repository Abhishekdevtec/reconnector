# frozen_string_literal: true
#
# Class which holds data
# from the 'country' table
module AquityV2
  class Country < Base
    attribute :id,           :integer, default: nil
    attribute :country_name, :string,  default: nil
    attribute :country_code, :integer, default: nil
  end
end
