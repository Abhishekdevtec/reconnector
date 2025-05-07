# frozen_string_literal: true

module AquityV2Services
  class ImportPersonPropertyRequirement
    def initialize(person_property_requirement)
      @person_property_requirement = person_property_requirement
    end

    def create_person_property_requirement!
      if !requirement_alread_exists?
        puts "Need to create a requirement for #{contact.email}"
      end
      return if requirement_alread_exists?

      contact.property_requirements.create! do |reqm|
        reqm.property_type = @person_property_requirement.property_type.property_type_name
        reqm.contract_type = @person_property_requirement.contract_type.contract_type_name
        reqm.area_from     = @person_property_requirement.area_from_in_sq_meter
        reqm.area_to       = @person_property_requirement.area_to_in_sq_meter
        reqm.price_from    = @person_property_requirement.price_from
        reqm.price_to      = @person_property_requirement.price_to
        reqm.active        = @person_property_requirement.is_active
        reqm.for_sale      = for_sale?
        reqm.for_lease     = for_lease?
      end
    end

    private

    def contact
      @contact ||= Contact.find_by!(source_id: @person_property_requirement.person_id)
    end

    def requirement_alread_exists?
      contact.property_requirements.exists?(
        property_type: @person_property_requirement.property_type.property_type_name,
        contract_type: @person_property_requirement.contract_type.contract_type_name,
        area_from: @person_property_requirement.area_from_in_sq_meter,
        area_to: @person_property_requirement.area_to_in_sq_meter,
        price_from_cents: (@person_property_requirement.price_from.to_f * 100).to_i,
        price_to_cents: (@person_property_requirement.price_to.to_f * 100).to_i,
        active: @person_property_requirement.is_active,
        for_sale: for_sale?,
        for_lease: for_lease?
      )
    end

    def for_sale?
      @person_property_requirement.contract_type.contract_type_name.downcase.include?('sale')
    end

    def for_lease?
      @person_property_requirement.contract_type.contract_type_name.downcase.include?('lease')
    end
  end
end
