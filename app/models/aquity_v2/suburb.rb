# frozen_string_literal: true
#
# Class which holds data
# from the 'suburb' table
module AquityV2
  class Suburb < Base
    attribute :id,              :integer, default: nil
    attribute :district_id,     :integer, default: nil
    attribute :suburb_name,     :string,  default: nil
    attribute :postal_zip_code, :string,  default: nil

    # Associations
    attr_accessor :district
  end
end
