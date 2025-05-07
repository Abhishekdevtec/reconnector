# frozen_string_literal: true

# Model which stores inbound webhook requests
# which are then processed asynchronously
# once the request has been saved.
class InboundWebhook < ApplicationRecord
  include Processable

  belongs_to :account
end

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
