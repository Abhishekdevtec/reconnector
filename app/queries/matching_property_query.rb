# frozen_string_literal: true

# Query Object which takes in a PropertyRequirement
# and returns matching properties.
class MatchingPropertyQuery
  attr_accessor :property_requirement

  def initialize(property_requirement)
    @property_requirement = property_requirement
  end

  def call
    records = search_properties
    records = filter_by_property_type(records)
    records = filter_by_contract_type(records)
    records = filter_by_suburb(records)
    records = filter_by_price(records)
    records = filter_by_area(records)
    records = filter_by_district(records)
    properties_by_id(records)
  end

  private

  def search_properties
    agent.properties.all.joins(:contract)
  end

  def filter_by_property_type(records)
    @property_requirement.property_type.present? ? records.where(type: "#{@property_requirement.property_type}Property") : records
  end

  def filter_by_contract_type(records)
    records = records.where('contracts.for_sale = ?',  @property_requirement.for_sale) if @property_requirement.for_sale? && !@property_requirement.for_lease?
    records = records.where('contracts.for_lease = ?', @property_requirement.for_lease) if @property_requirement.for_lease? && !@property_requirement.for_sale?
    records
  end

  def filter_by_district(records)
    if @property_requirement.district_id.present?
      district = District.find_by(id: @property_requirement.district_id) 
   
      if district.present? && district.cities.any?
        city_names = district.cities.pluck(:name)
        postal_codes = district.cities.pluck(:postal_code)
        records = records.where(
          Property.arel_table[:city].in(city_names)
          .or(Property.arel_table[:postal_code].in(postal_codes))
        )
      end
    end
    records
  end

  def filter_by_suburb(records)
    if @property_requirement.suburbs.present?
      suburb_data = suburb_names
      suburb_names = suburb_data.map { |name, _| name.downcase }
      postal_codes = suburb_data.map { |_, postal_code| postal_code }
  
      records = records.where(
        Property.arel_table[:city].matches_any(suburb_names)
        .or(Property.arel_table[:postal_code].in(postal_codes))
      )
    end
    records
  end

  def filter_by_price(records)
    if @property_requirement.for_sale
      records = records.where('contracts.sale_price_cents >= ?', @property_requirement.price_from_cents) if @property_requirement.price_from.present? # && @property_requirement.price_from_cents.positive?
      records = records.where('contracts.sale_price_cents <= ?', @property_requirement.price_to_cents) if @property_requirement.price_to.present? # && @property_requirement.price_to_cents.positive?
    end

    if @property_requirement.for_lease
      records = records.where('contracts.lease_gross_rent >= ?', @property_requirement.price_from_cents / 100.0) if @property_requirement.price_from.present? # && @property_requirement.price_from_cents.positive?
      records = records.where('contracts.lease_gross_rent <= ?', @property_requirement.price_to_cents / 100.0) if @property_requirement.price_to.present? # && @property_requirement.price_to_cents.positive?
    end
    records
  end

  def filter_by_area(records)
    records.where(calculated_building_area: [@property_requirement.area_from..@property_requirement.area_to])
  end

  def properties_by_id(records)
    property_ids = records.map(&:id)
    Property.where(id: property_ids).includes(:contract)# .includes(:prospect_notification_emails).joins('prospect_notification_emails.contact_id = ?', contact.id)
  end

  def contact
    @property_requirement.contact
  end

  def agent
    contact.agent
  end

  def suburb_names
    City.where(id: property_requirement.suburbs).pluck(:name, :postal_code) if property_requirement.suburbs.present?
  end
end
