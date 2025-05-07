# frozen_string_literal: true

module AquityV2Services
  class CreateAgentFromUser
    def initialize(account:, user:)
      @account = account
      @user    = user
    end

    def create_agent_from_user!
      return if agent_modified_recently?

      Agent.find_or_create_by!(email: @user.email, account_id: @account.id) do |agent|
        agent.first_name = @user.first_name
        agent.last_name  = @user.last_name
        agent.mobile     = @user.mobile_phone
        agent.password   = default_password
        agent.role       = agent_role(@user.user_level)
      end
    end

    private

    def default_password
      'aquity_v3_password'
    end

    def agent_role(user_level)
      case user_level.user_level_name.downcase
      when 'agent'
        :agent
      when 'admin'
        :admin
      when 'super admin'
        :account_manager
      else
        :agent
      end
    end

    def agent_modified_recently?
      return false if agent.nil?

      agent.updated_at.after?(@user.modified_date)
    end

    def agent
      @agent ||= Agent.find_by(email: @user.email, account_id: @account.id)
    end
  end
end
