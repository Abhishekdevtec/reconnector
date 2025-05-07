# == Schema Information
#
# Table name: districts
#
#  country_id :bigint           not null
#  created_at :datetime         not null
#  id         :bigint           not null, primary key
#  name       :string
#  updated_at :datetime         not null
#
# Indexes
#
#  index_districts_on_country_id  (country_id)
#
require "test_helper"

class DistrictTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
