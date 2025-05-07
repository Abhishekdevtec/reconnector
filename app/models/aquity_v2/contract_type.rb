# frozen_string_literal: true
#
# Class which holds data
# from the 'contract_type' table
module AquityV2
  class ContractType < Base
    attribute :id,                 :integer, default: nil
    attribute :contract_type_name, :string,  default: nil

    def contract_type
      contract_type_name.downcase.to_sym
    end
  end
end
