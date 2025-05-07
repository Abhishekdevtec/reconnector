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
require "test_helper"

class PropertyRequirementTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
