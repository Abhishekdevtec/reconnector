# == Schema Information
#
# Table name: countries
#
#  country_code :string
#  created_at   :datetime         not null
#  id           :bigint           not null, primary key
#  name         :string
#  slug         :string
#  updated_at   :datetime         not null
#
# Indexes
#
#  index_countries_on_name  (name)
#  index_countries_on_slug  (slug)
#
require "test_helper"

class CountryTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
