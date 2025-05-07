module PropertyRequirementsHelper
  def property_requirement_header(property_requirement)
    return nil if property_requirement.nil?

    [
      property_requirements_property_type_label(property_requirement),
      property_requirement.lease_sale_label.downcase
    ].compact.join(' ')
  end

  def property_requirements_label(property_requirement)
    return nil if property_requirement.nil?

    [
      property_requirements_property_type_label(property_requirement),
      property_requirement.lease_sale_label.downcase,
      property_requirements_area_label(property_requirement),
      property_requirements_price_label(property_requirement)
    ].compact.join(', ')
  end

  def property_requirements_property_type_label(property_requirement)
    return nil if property_requirement.property_type.blank?

    "#{property_requirement.property_type} properties"
  end

  def property_requirements_area_label(property_requirement)
    if property_requirement.area_from.present? && property_requirement.area_to.present?
      "beween #{property_requirement.area_from} and #{property_requirement.area_to} square meters"
    elsif property_requirement.area_from.present?
      "from #{property_requirement.area_from} square meters"
    elsif property_requirement.area_to.present?
      "to #{property_requirement.area_to} square meters"
    end
  end

  def property_requirements_price_label(property_requirement)
    if property_requirement.price_from.present? && property_requirement.price_to.present?
      "#{number_to_currency(property_requirement.price_from)} to #{number_to_currency(property_requirement.price_to)}"
    elsif property_requirement.price_from.present?
      "from #{number_to_currency(property_requirement.price_from)}"
    elsif property_requirement.price_to.present?
      "to #{number_to_currency(property_requirement.price_to)}"
    end
  end

  def property_requirements_suburb_names(property_requirement)
    return nil if property_requirement.suburbs.blank?

    City.where(id: property_requirement.suburbs).select(:name, :postal_code).map(&:label).to_sentence
  end
end
