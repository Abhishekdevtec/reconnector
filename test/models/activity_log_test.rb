# == Schema Information
#
# Table name: activity_logs
#
#  account_id            :bigint           not null
#  action                :string
#  activityloggable_id   :bigint           not null
#  activityloggable_type :string           not null
#  agent_id              :bigint
#  body                  :string
#  created_at            :datetime
#  id                    :bigint           not null, primary key
#  payload               :string
#  result                :string
#
# Indexes
#
#  index_activity_logs_on_account_id        (account_id)
#  index_activity_logs_on_activityloggable  (activityloggable_type,activityloggable_id)
#  index_activity_logs_on_agent_id          (agent_id)
#
require "test_helper"

class ActivityLogTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
