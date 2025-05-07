# frozen_string_literal: true

class PropertyBrochure
  include ActiveSupport::NumberHelper

  delegate :short_address, to: :@property
  delegate :type_label,    to: :@property
  delegate :images,        to: :@property

  def initialize(property)
    @property = property
  end

  def author
    account.company_name
  end

  def title
    "#{account.company_name} PDF"
  end

  def company_name
    account.company_name
  end

  def legal_name
    account.legal_name
  end

  def property_name
    @property.name
  end

  def brochure_header
    @property.contract.lease_sale_label
  end

  def usages
    @property.usages.collect { |u| u.titleize }.join(', ')
  end

  def brochure_description
    @property.brochure_description.to_plain_text
  end

  def area_attributes
    attribs = []
    %i[office_area warehouse_area showroom_area storage_area production_area trading_area floor_area land_area hard_stand_yard_area].each do |val|
      attribs << [Property.human_attribute_name(val), @property[val]] if @property[val].present? && @property[val].positive?
    end
    attribs << ['Building area', @property.building_area] if @property.building_area.present? && @property.building_area.positive?
    attribs << ['Total floor and land area', @property.total_area] if @property.total_area.present? && @property.total_area.positive?
    attribs
  end

  def detail_attributes
    attribs = []
    attribs << [Property.human_attribute_name(:parking_spaces), @property.parking_spaces] if @property.parking_spaces?
    attribs << [Property.human_attribute_name(:zoning), @property.zoning] if @property.zoning&.present?
    attribs << [Property.human_attribute_name(:rating), @property.rating] if @property.rating&.present?
    attribs << [Property.human_attribute_name(:disability_access), @property.disability_access] if @property.disability_access&.present?
    attribs << [Property.human_attribute_name(:naming_rights), @property.naming_rights] if @property.naming_rights&.present?
    attribs << [Property.human_attribute_name(:entrances_roller_doors_container_access), @property.entrances_roller_doors_container_access] if @property.entrances_roller_doors_container_access&.present?
    attribs << [Property.human_attribute_name(:crane), @property.crane] if @property.crane&.present?
    attribs
  end

  def contract_attributes
    attribs = []

    if @property.contract.for_sale?
      attribs << [Contract.human_attribute_name(:sale_price), @property.contract.sale_actual_sale_price] if @property.contract.sale_actual_sale_price.present? && @property.contract.sale_actual_sale_price.positive?
    elsif @property.contract.for_lease?
      attribs << [Contract.human_attribute_name(:lease_net_rent), number_to_currency(@property.contract.lease_net_rent)] if @property.contract.lease_net_rent.present? && @property.contract.lease_net_rent.positive?
      attribs << [Contract.human_attribute_name(:lease_gross_rent), number_to_currency(@property.contract.lease_gross_rent)] if @property.contract.lease_gross_rent.present? && @property.contract.lease_gross_rent.positive?
      attribs << [Contract.human_attribute_name(:lease_outgoings), number_to_currency(@property.contract.lease_outgoings)] if @property.contract.lease_outgoings.present? && @property.contract.lease_outgoings.positive?
      attribs << [Contract.human_attribute_name(:lease_cleaning), number_to_currency(@property.contract.lease_cleaning)] if @property.contract.lease_cleaning.present? && @property.contract.lease_cleaning.positive?
      attribs << [Contract.human_attribute_name(:lease_covered_parking_space), number_to_currency(@property.contract.lease_covered_parking_space)] if @property.contract.lease_covered_parking_space.present? && @property.contract.lease_covered_parking_space.positive?
      attribs << [Contract.human_attribute_name(:lease_on_grade_parking_space), number_to_currency(@property.contract.lease_on_grade_parking_space)] if @property.contract.lease_on_grade_parking_space.present? && @property.contract.lease_on_grade_parking_space.positive?
      attribs << [Contract.human_attribute_name(:lease_other_rental_costs), number_to_currency(@property.contract.lease_other_rental_costs)] if @property.contract.lease_other_rental_costs.present? && @property.contract.lease_other_rental_costs.positive?
    end

    attribs
  end

  def brochure_footer
    ["#{@property.agent.name}", @property.agent.mobile, @property.agent.email, account.url].join(' - ')
  end

  def primary_color
    '3c4981'
  end

  def secondary_color
    '73c92d'
  end

  def has_photos?
    @property.images.attached?
  end

  def has_pdf_logo?
    account.pdf_logo.present?
  end

  def pdf_logo
    ActiveStorage::Blob.service.send(:path_for, account.pdf_logo.blob.key)
  end

  def account
    @account ||= @property.account
  end
end
