module Contacts
  class MatchingPropertiesEmailsController < ApplicationController
    include ActiveStorage::SetCurrent

    before_action :authenticate_agent!
    before_action :set_contact

    # GET /matching_properties_emails/new
    def new
      if @current_agent.sends_email_via_microsoft_graph? &&
        !(@current_agent.microsoft_graph_token_missing? || @current_agent.microsoft_graph_token.expired?)
        redirect_to edit_agent_path(@current_agent), alert: 'You are not connected to Microsoft Office online. Please connect to Microsoft Graph to send emails.'
      else
        @matching_properties_email = MatchingPropertiesEmail.new(body: default_email_body)
        set_tab_option(:matching_properties)
      end
    end

    # POST /matching_properties_emails or /matching_properties_emails.json
    def create
      set_tab_option(:matching_properties)
      email_service = AppServices::Contacts::MatchingPropertiesEmailer.new(matching_properties_email_params)
      @matching_properties_email = email_service.object

      respond_to do |format|
        if email_service.save && email_service.send_matching_properties_email
          format.html { redirect_to @matching_properties_email.contact, notice: 'Matching property email was sent.' }
          format.json { render :show, status: :created, location: @matching_properties_email }
        else
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @matching_properties_email.errors, status: :unprocessable_entity }
        end
      end
    end

    private

    def default_email_body
      params? ? matching_properties_email_params[:body] : email_template
    end

    def params?
      begin
        params.require(:matching_properties_email)
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
    def matching_properties_email_params
      params.require(:matching_properties_email)
            .permit(:body, :attach_brochures, files: [])
            .merge({ property_ids: params[:property_ids], agent: @current_agent, contact: @contact })
    end

    def set_contact
      @contact = @current_agent.visible_contacts.find(params[:contact_id])
    end
  end
end
