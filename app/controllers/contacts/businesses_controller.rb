module Contacts
  class BusinessesController < ContactsController
    # GET /businesses or /businesses.json
    def index
      @pagy, @contacts = pagy(visible_businesses.order(:business_name))
    end

    # GET /businesses/1 or /businesses/1.json
    def show; end

    # GET /businesses/new
    def new
      @business = @current_agent.businesses.build
      build_new_contact_addresses(@business)
    end

    # GET /businesses/1/edit
    def edit
      @business = visible_businesses.find(params[:id])
      @business.physical_address ||= @business.build_physical_address
      @business.postal_address ||= @business.build_postal_address
    end

    # POST /businesses or /businesses.json
    def create
      @business = @current_agent.businesses.build(create_business_params)
      create_contact = ContactServices::CreateContact.new.create_contact(@business)

      if create_contact.created?
        redirect_to @business, notice: 'Business was successfully created.'
      else
        render :new, status: :unprocessable_entity
      end
    end

    # PATCH/PUT /businesses/1 or /businesses/1.json
    def update
      @business = visible_businesses.find(params[:id])
      update_contact = ContactServices::UpdateContact.new.update_contact(@business, create_business_params)

      if update_contact.updated?
        redirect_to update_contact.contact, notice: 'Business was successfully updated.'
      else
        render :edit, status: :unprocessable_entity
      end
    end

    private

    def visible_businesses
      @account.businesses.visible_by(@current_agent)
    rescue ActiveRecord::RecordNotFound
      Rails.logger.info "SECURITY: #{@current_agent.name} is trying to access Business (id #{params[:id]}) from a different account (account id #{@account.id})"
      redirect_to [:contacts]
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_contact
      @business = visible_businesses.find(params[:id])
    end

    def new_business_params
      params.merge(account_id: @current_agent.account_id)
    end

    def create_business_params
      params
        .require(:business)
        .permit(
          :share,
          :business_name,
          :legal_name,
          :email,
          :phone,
          :mobile,
          :fax,
          :url,
          :registration,
          :notes,
          classifier_ids: [],
          physical_address_attributes: [:id, :line_1, :line_2, :line_3, :city, :state, :postal_code, :country],
          postal_address_attributes: [:id, :line_1, :line_2, :line_3, :city, :state, :postal_code, :country]
        )
        .merge(
          agent_id: @current_agent.id,
          account_id: @current_agent.account_id,
          type: 'Business'
        )
    end
  end
end
