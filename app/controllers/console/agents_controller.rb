# frozen_string_literal: true

module Console
  class AgentsController < ConsoleController
    before_action :set_agent, only: %i[show edit update destroy]

    def index
      @agents = @account.agents
                        .order(:last_name, :first_name)
                        .pluck(:first_name, :last_name, :email, :role)
    end

    def show
    end

    def new
      @agent = @account.agents.new
    end

    def create
      @agent = @account.agents.new(agent_params)
      if @agent.save
        redirect_to [:console, @account, @agent], notice: "#{@agent.name} was saved."
      else
        redirect_to [:new, :console, @account, :agent], alert: 'Cannot save agent'
      end
    end

    def edit
    end

    def update
      respond_to do |format|
        if @agent.update(agent_params)
          format.html { redirect_to [:console, @account, @agent], notice: "#{@agent.name} was successfully updated." }
          format.json { render :show, status: :ok, location: @account }
        else
          format.html { render :edit, status: :unprocessable_entity }
          format.json { render json: @agent.errors, status: :unprocessable_entity }
        end
      end
    end

    def destroy
      @agent.destroy
      respond_to do |format|
        format.html { redirect_to [:console, @account], notice: "#{@agent.name} was successfully destroyed." }
        format.json { head :no_content }
      end
    end

    private

    def set_agent
      @agent = @account.agents.find(params[:id])
    end

    def agent_params
      # TODO: Find a better way to drop in ews attributes
      params
        .require(:agent)
        .permit(:account_id, :first_name, :last_name, :email, :password, :password_confirmation, :phone, :mobile, :rea_agent_id)
    end
  end
end
