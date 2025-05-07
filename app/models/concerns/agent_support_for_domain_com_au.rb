# frozen_string_literal: true

# app/models/concerns/agent_support_for_domain_com_au.rb
# Agent fields to support the Domain.com.au API

module AgentSupportForDomainComAu
  extend ActiveSupport::Concern

  included do
    # Returns the Agency ID for domain.com.au
    delegate :domain_com_au_agency_id, to: :account
  end
end
