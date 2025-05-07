class Contract < ApplicationRecord
  include HasMoneytaryAttributes
  include LeaseableAndSellable

  validate do |contract|
    ContractMustBeForLeaseOrForSale.new(contract).validate
  end

  after_initialize :set_default_values

  belongs_to :property

  # Use HasMoneytaryAttributes to generate
  # helper methods
  monetary_attribute :sale_price
  monetary_attribute :sale_price_from
  monetary_attribute :sale_price_to
  monetary_attribute :sale_reserve_price
  monetary_attribute :sale_actual_sale_price
  monetary_attribute :private_treaty_minimum_price
  monetary_attribute :private_treaty_target_price
  monetary_attribute :eoi_minimum_price
  monetary_attribute :eoi_target_price
  monetary_attribute :lease_cleaning
  monetary_attribute :lease_covered_parking_space
  monetary_attribute :lease_on_grade_parking_space
  monetary_attribute :lease_other_rental_costs

  # Either put in NET RENT PER SQM and OUTGOINGS PER SQM,
  # then the TOTAL GROS RENT IS CALCULATED
  # OR put in GROSS RENT PER SQM, then the TOTAL GROS RENT IS CALCULATED
  def lease_total_net_rent
    return nil if lease_net_rent.blank?
    return nil if property.building_area.blank?

    property.building_area * lease_net_rent
  end

  def lease_total_outgoings
    return nil if lease_outgoings.blank?
    return nil if property.building_area.blank?

    property.building_area * lease_outgoings
  end

  # If we have a price per sqm then we
  # calculate the lease_total_gross_rent
  # else we addition lease_total_net_rent and
  # lease_total_outgoings.
  def lease_total_gross_rent
    if lease_gross_rent.present? &&
       lease_gross_rent.positive? &&
       property.building_area.present?
      property.building_area * lease_gross_rent
    elsif lease_total_net_rent.present? &&
      lease_total_net_rent.positive? &&
      lease_total_outgoings.present? &&
      lease_total_outgoings.positive?
      [lease_total_net_rent, lease_total_outgoings].compact_blank.reduce(:+)
    end
  end

  def lease_gross_rent_cents
    (lease_gross_rent * 100).to_i if lease_gross_rent.present?
  end

  def for_sale?
    for_sale
  end

  def for_lease?
    for_lease
  end

  private

  def set_default_values
    self.for_sale ||= false
    self.for_lease ||= false
    self.lease_expires_on ||= 3.years.from_now
  end
end

# == Schema Information
#
# Table name: contracts
#
#  created_at                         :datetime         not null
#  eoi_close_on                       :date
#  eoi_inspection_on                  :date
#  eoi_minimum_price_cents            :bigint
#  eoi_target_price_cents             :bigint
#  for_lease                          :boolean          default(FALSE)
#  for_sale                           :boolean          default(FALSE)
#  id                                 :bigint           not null, primary key
#  lease_cleaning_cents               :bigint
#  lease_commencement_on              :date
#  lease_covered_parking_space_cents  :bigint
#  lease_escalation_formulae          :string
#  lease_escalation_rate              :text
#  lease_expires_on                   :date
#  lease_gross_rent                   :decimal(20, 8)
#  lease_net_rent                     :decimal(20, 8)
#  lease_on_grade_parking_space_cents :bigint
#  lease_other_rental_costs_cents     :bigint
#  lease_outgoings                    :decimal(20, 8)
#  lease_rent_review_on               :date
#  lease_term                         :string
#  private_treaty_minimum_price_cents :bigint
#  private_treaty_target_price_cents  :bigint
#  property_id                        :bigint           not null
#  sale_actual_sale_price_cents       :bigint
#  sale_auction_date                  :date
#  sale_auction_venue                 :string
#  sale_inspection_on                 :date
#  sale_price_cents                   :bigint
#  sale_price_from_cents              :bigint
#  sale_price_to_cents                :bigint
#  sale_reserve_price_cents           :bigint
#  updated_at                         :datetime         not null
#
# Indexes
#
#  index_contracts_on_property_id  (property_id)
#
