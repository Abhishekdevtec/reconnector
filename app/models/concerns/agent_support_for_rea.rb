# frozen_string_literal: true

# app/models/concerns/agent_support_for_rea.rb
# Agent fields to RealEstate.com.au support

module AgentSupportForRea
  extend ActiveSupport::Concern

  def can_upload_to_rea?
    rea_agent_id.present?
  end
end
