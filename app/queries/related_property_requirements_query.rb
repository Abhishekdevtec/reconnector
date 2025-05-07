# frozen_string_literal: true

# Query Object which takes in a property and returns the related requirements
class RelatedPropertyRequirementsQuery
  attr_accessor :property, :contract

  def initialize(property)
    @property = property
    @contract = property.contract
  end

  def call
    records = property_requirements
    records = filter_by_contract_type(records)
    records = filter_by_price(records)
    records = filter_by_area(records)
    records = filter_by_suburb(records)
    records
  end

  private

  def property_requirements
    PropertyRequirement.where(
      contact_id: visible_contact_ids,
      property_type: property_type
    )
  end

  def filter_by_contract_type(records)
    if @contract.for_sale && @contract.for_lease
      records.where(for_sale: true).or(records.where(for_lease: true))
    elsif @contract.for_sale
      records.where(for_sale: true)
    elsif @contract.for_lease
      records.where(for_lease: true)
    end
  end

  def filter_by_price(records)
    if @contract.for_sale?
      records = records.where(price_from_cents: [0, nil]).or(records.where('price_from_cents < ?', @contract.sale_actual_sale_price_cents))
      records = records.where(price_to_cents:   [0, nil]).or(records.where('price_to_cents > ?',   @contract.sale_actual_sale_price_cents))
    end
    if @contract.for_lease?
      records = records.where(price_from_cents: [0, nil]).or(records.where('price_from_cents <= ?', @contract.lease_gross_rent_cents))
      records = records.where(price_to_cents:   [0, nil]).or(records.where('price_to_cents >= ?',   @contract.lease_gross_rent_cents))
    end
    records
  end

  def filter_by_area(records)
    records = records.where(area_from: [0, nil]).or(records.where('area_from <= ?', @property.building_area))
    records = records.where(area_to:   [0, nil]).or(records.where('area_to >= ?',   @property.building_area))
    records
  end

  def filter_by_suburb(records)
    records.where(suburbs: suburb_ids).or(records.where(suburbs: [])) if @property.city.present?
  end

  def property_type
    @property.type.delete_suffix('Property')
  end

  def visible_contact_ids
    [@property.agent.visible_contacts]
  end

  def suburb_ids
    City.where(name: @property.city.upcase).pluck(:id)
  end
end
