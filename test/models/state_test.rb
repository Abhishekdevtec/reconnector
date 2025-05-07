# == Schema Information
#
# Table name: states
#
#  abbreviation :string
#  country_id   :bigint           not null
#  created_at   :datetime         not null
#  id           :bigint           not null, primary key
#  name         :string
#  updated_at   :datetime         not null
#
# Indexes
#
#  index_states_on_abbreviation  (abbreviation)
#  index_states_on_country_id    (country_id)
#  index_states_on_name          (name)
#
require "test_helper"

class StateTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
