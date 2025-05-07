# frozen_string_literal: true

# No need to set/find @agent since it is
# managed in ApplicationController as
# @current_agent
class AgentsController < ApplicationController
  before_action :authenticate_agent!

  # GET /agent/1 or /agent/1.json
  def show; end

  # GET /agent/1/edit
  def edit
    @current_agent.build_location if @current_agent.location.nil?
  end

  # PATCH/PUT /agent/1 or /agent/1.json
  def update
    if @current_agent.update(agent_params)
      redirect_to edit_agent_path, notice: 'Your information was updated.'
    else
      redirect_to edit_agent_path, alert: @current_agent.errors.full_messages
    end
  end

  private

  # Only allow a list of trusted parameters through.
  def agent_params
    params
      .require(:agent)
      .permit(
        :email,
        :first_name,
        :last_name,
        :phone,
        :mobile,
        :rea_agent_id,
        :domain_com_au_agent_id,
        :fax,
        :ews_username,
        :ews_password,
        addresses_attributes: [:id, :line_1, :line_2, :line_3, :city, :state, :country_id, :account_id],
        location_attributes: [:id, :time_zone]
      )
  end
end
