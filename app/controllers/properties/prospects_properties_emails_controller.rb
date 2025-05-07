# frozen_string_literal: true

module Properties
  class ProspectsPropertiesEmailsController < ApplicationController
    include ActiveStorage::SetCurrent

    before_action :authenticate_agent!
    before_action :set_property

    # GET /properties/:property_id/prospects_properties_emails/new(.:format)
    def new
      if @current_agent.sends_email_via_microsoft_graph? &&
        (@current_agent.microsoft_graph_token_missing? || @current_agent.microsoft_graph_token.expired?)
        redirect_to edit_agent_path(@current_agent), alert: 'You are not connected to Microsoft Office online. Please connect to Microsoft Graph to send emails.'
      else
        @prospects_properties_email = ProspectsPropertiesEmail.new(body: default_email_body)
        @current_property_tab = :email_property_prospects
      end
    end

    # POST /properties/:property_id/prospects_properties_emails(.:format)
    def create
      @current_property_tab = :email_property_prospects
      # @prospects_properties_email = ProspectsPropertiesEmail.new(prospects_properties_email_params)
      email_service = AppServices::Properties::ProspectsPropertiesEmailer.new(prospects_properties_email_params)
      @prospects_properties_email = email_service.object

      respond_to do |format|
        if email_service.save && email_service.send_prospects_properties_email
        # if @prospects_properties_email.save
          count = @prospects_properties_email&.contact_ids&.count
          format.html { redirect_to @property, notice: t('.success', count: count) }
          format.json { render :show, status: :created, location: @prospects_properties_email }
        else
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @prospects_properties_email.errors, status: :unprocessable_entity }
        end
      end
    end

    private

    def default_email_body
      params? ? prospects_properties_email[:body] : email_template
    end

    def params?
      begin
        params.require(:prospects_properties_email)
      rescue ActionController::ParameterMissing
        return false
      end
      true
    end

    def email_template
      render_to_string(
        partial: 'email_template',
        layout: false,
        locals: {
          agent: @current_agent,
          contact: @contact
        },
        formats: [:html]
      )
    end

    # Only allow a list of trusted parameters through.
    def prospects_properties_email_params
      params.require(:prospects_properties_email)
            .permit(:body, :attach_brochures, files: [])
            .merge({ agent: @current_agent })
            .merge({ contact_ids: params[:contact_ids] })
            .merge({ property_ids: [params[:property_id]] })
    end

    def set_property
      @property = Current.account.properties.with_archived.find(params[:property_id])
    end
  end
end
