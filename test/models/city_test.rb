# == Schema Information
#
# Table name: cities
#
#  created_at  :datetime         not null
#  district_id :bigint
#  id          :bigint           not null, primary key
#  name        :string
#  postal_code :string
#  state_id    :bigint           not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_cities_on_district_id  (district_id)
#  index_cities_on_state_id     (state_id)
#
require "test_helper"

class CityTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
