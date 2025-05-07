# == Schema Information
#
# Table name: locations
#
#  agent_id   :bigint           not null
#  created_at :datetime         not null
#  id         :bigint           not null, primary key
#  time_zone  :string           default("UTC")
#  updated_at :datetime         not null
#
# Indexes
#
#  index_locations_on_agent_id  (agent_id)
#
require "test_helper"

class LocationTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
