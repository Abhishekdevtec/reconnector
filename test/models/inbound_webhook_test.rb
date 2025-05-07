# == Schema Information
#
# Table name: inbound_webhooks
#
#  account_id :bigint           not null
#  body       :text
#  created_at :datetime         not null
#  id         :bigint           not null, primary key
#  status     :string           default("pending")
#  updated_at :datetime         not null
#
# Indexes
#
#  index_inbound_webhooks_on_account_id  (account_id)
#
require "test_helper"

class InboundWebhookTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
