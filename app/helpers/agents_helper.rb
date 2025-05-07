# frozen_string_literal: true

module AgentsHelper
  def agent_role_options
    Agent.roles.keys.map do |role|
      [t("activerecord.attributes.agent.roles.#{role}"), role]
    end
  end

  def translated_agent_role(agent)
    t("activerecord.attributes.agent.roles.#{agent.role}")
  end
end
