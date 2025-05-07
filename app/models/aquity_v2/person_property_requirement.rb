# frozen_string_literal: true
#
# Class which holds data
# from the 'person_property_requirement' table
module AquityV2
  class PersonPropertyRequirement < Base
    attribute :id,                    :integer, default: nil
    attribute :person_id,             :integer, default: nil
    attribute :contract_type_id,      :integer, default: nil
    attribute :property_type_id,      :integer, default: nil
    attribute :area_unit_id,          :integer, default: nil
    attribute :area_from,             :float,   default: nil
    attribute :area_from_in_sq_meter, :float,   default: nil
    attribute :area_to,               :float,   default: nil
    attribute :area_to_in_sq_meter,   :float,   default: nil
    attribute :district_id,           :integer, default: nil
    attribute :price_currency_id,     :integer, default: nil
    attribute :price_from,            :float,   default: nil
    attribute :price_to,              :float,   default: nil
    attribute :is_active,             :boolean, default: nil
    attribute :created_by,            :integer, default: nil
    attribute :created_date,          :date,    default: nil
    attribute :modified_by,           :integer, default: nil
    attribute :modified_date,         :date,    default: nil

    # Associations
    attr_accessor :contract_type, :property_type
  end
end
