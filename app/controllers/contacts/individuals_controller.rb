# frozen_string_literal: true

module Contacts
  class IndividualsController < ContactsController
    # GET /individuals or /individuals.json
    def index
      @pagy, @contacts = pagy(visible_individuals.order(:last_name))
    end

    # GET /individuals/1 or /individuals/1.json
    def show; end

    # GET /individuals/new
    def new
      @individual = @current_agent.individuals.build
      build_new_contact_addresses(@individual)
    end

    # GET /individuals/1/edit
    def edit
      @individual = visible_individuals.find(params[:id])
      @individual.physical_address ||= @individual.build_physical_address
      @individual.postal_address ||= @individual.build_postal_address
    end

    # POST /individuals or /individuals.json
    def create
      @individual = @current_agent.individuals.build(create_individual_params)
      create_contact = ContactServices::CreateContact.new.create_contact(@individual)

      if create_contact.created?
        redirect_to @individual, notice: 'Individual was successfully created.'
      else
        render :new, status: :unprocessable_entity
      end
    end

    # PATCH/PUT /individuals/1 or /individuals/1.json
    def update
      @individual = visible_individuals.find(params[:id])
      update_contact = ContactServices::UpdateContact.new.update_contact(@individual, create_individual_params)

      if update_contact.updated?
        redirect_to update_contact.contact, notice: 'Individual was successfully updated.'
      else
        render :edit, status: :unprocessable_entity
      end
    end

    private

    def visible_individuals
      @account.individuals.visible_by(@current_agent)
    rescue ActiveRecord::RecordNotFound
      Rails.logger.info "SECURITY: #{@current_agent.name} is trying to access Individual (id #{params[:id]}) from a different account (account id #{@account.id})"
      redirect_to [:contacts]
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_contact
      @individual = visible_individuals.find(params[:id])
    end

    def new_individual_params
      params.merge(account_id: @current_agent.account_id)
    end

    def create_individual_params
      params
        .require(:individual)
        .permit(
          :share,
          :first_name,
          :last_name,
          :business_name,
          :job_title,
          :email,
          :phone,
          :mobile,
          :fax,
          :url,
          :registration,
          :notes,
          :synchronize_with_office_online,
          classifier_ids: [],
          physical_address_attributes: [:id, :line_1, :line_2, :line_3, :city, :state, :postal_code, :country],
          postal_address_attributes: [:id, :line_1, :line_2, :line_3, :city, :state, :postal_code, :country]
        )
        .merge(
          agent_id: @current_agent.id,
          account_id: @current_agent.account_id,
          type: 'Individual'
        )
    end
  end
end
