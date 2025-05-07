# frozen_string_literal: true
#
# Class which holds data
# from the 'property_user' table
module AquityV2
  class PropertyUser < Base
    attribute :property_id, :integer, default: nil
    attribute :lister,      :string,  default: nil
    attribute :userid,      :integer, default: nil
  end
end
