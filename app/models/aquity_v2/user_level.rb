# frozen_string_literal: true
#
# Class which holds data
# from the 'user_level' table
module AquityV2
  class UserLevel < Base
    attribute :id,              :integer, default: nil
    attribute :user_level_name, :string,  default: nil
  end
end
