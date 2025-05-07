# frozen_string_literal: true

class Integrations::RealestateComAu::LeadsApi < ApplicationRecord
  attribute :enabled, :boolean, default: false
  attribute :last_requested_at, :datetime, default: 30.days.ago

  belongs_to :account

  validates :account, presence: true
  validates :last_requested_at, presence: true
end

# == Schema Information
#
# Table name: integrations_realestate_com_au_leads_apis
#
#  account_id          :bigint           not null
#  created_at          :datetime         not null
#  enabled             :boolean
#  id                  :bigint           not null, primary key
#  last_request_status :string
#  last_requested_at   :datetime
#  updated_at          :datetime         not null
#
# Indexes
#
#  index_integrations_realestate_com_au_leads_apis_on_account_id  (account_id)
#
