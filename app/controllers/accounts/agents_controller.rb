# frozen_string_literal: true

module Accounts
  class AgentsController < ApplicationController
    before_action :authenticate_agent!
    before_action :verify_account_manager!
    before_action :set_agent, only: %i[edit update]
    before_action :set_selected_account_menu_option

    def index
      @agents = Current.account.agents.all
    end

    def new
      @agent = Current.account.agents.new
      @agent.build_location
    end

    def create
      @agent = Current.account.agents.new(agent_params)
      @agent.password = SecureRandom.hex(10)
      @agent.password_confirmation = @agent.password

      if @agent.save
        redirect_to [Current.account, :agents], notice: t('.success')
      else
        redirect_to new_account_agent_path(@agent), alert: @agent.errors.full_messages
      end
    end

    def edit
    end

    def update
      if @agent.update(agent_params)
        redirect_to [Current.account, :agents], notice: t('.success')
      else
        redirect_to edit_account_agent_path(@agent), alert: @agent.errors.full_messages
      end
    end

    private

    def agent_params
      params
        .require(:agent)
        .permit(
          :email,
          :first_name,
          :last_name,
          :mobile,
          :phone,
          :role,
          location_attributes: [:id, :time_zone]
        )
    end

    def set_agent
      @agent = Current.account.agents.find(params[:id])
    end

    def set_selected_account_menu_option
      @selected_account_menu_option = :agents
    end
  end
end
