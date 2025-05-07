class PropertyRequirement < ApplicationRecord
  include HasMoneytaryAttributes
  include LeaseableAndSellable

  attribute :active, :boolean, default: true

  belongs_to :contact
  belongs_to :district, optional: true
  delegate :account, to: :contact

  monetary_attribute :price_from
  monetary_attribute :price_to

  def matching_properties
    MatchingPropertyQuery.new(self).call
  end

  def for_sale?
    for_sale
  end

  def for_lease?
    for_lease
  end

  private

  def keys_to_filter
    %w[id searchable_id searchable_type created_at updated_at account_id]
  end

  def strip_nil(hash)
    hash.select { |_k, v| v.present? }
  end
end

# == Schema Information
#
# Table name: property_requirements
#
#  active           :boolean
#  area_from        :decimal(10, 2)
#  area_to          :decimal(10, 2)
#  contact_id       :bigint           not null
#  contract_type    :string
#  created_at       :datetime         not null
#  district_id      :bigint
#  for_lease        :boolean          default(FALSE)
#  for_sale         :boolean          default(FALSE)
#  id               :bigint           not null, primary key
#  price_from_cents :integer
#  price_to_cents   :integer
#  property_type    :string
#  suburbs          :bigint           default([]), is an Array
#  updated_at       :datetime         not null
#
# Indexes
#
#  index_property_requirements_on_contact_id   (contact_id)
#  index_property_requirements_on_district_id  (district_id)
#
