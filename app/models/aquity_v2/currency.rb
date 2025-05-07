# frozen_string_literal: true
#
# Class which holds data
# from the 'currency' table
module AquityV2
  class Currency < Base
    attribute :id,            :integer, default: nil
    attribute :currency_name, :string,  default: nil
    attribute :currency_code, :string,  default: nil
    attribute :country_id,    :integer, default: nil
  end
end
