# frozen_string_literal: true
#
# Class which holds data
# from the 'company_individual' table
module AquityV2
  class CompanyIndividual < Base
    attribute :company_id,    :integer, default: nil
    attribute :individual_id, :integer, default: nil
  end
end
