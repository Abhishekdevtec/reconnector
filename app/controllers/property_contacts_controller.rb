class PropertyContactsController < ApplicationController
  before_action :authenticate_agent!
  before_action :set_property
  before_action :set_property_contact, only: %i[show edit update destroy]
  before_action :set_nav_menu

  AMOUNT_OF_CONTACTS_DISPLAYED = 20.freeze

  # GET /property_contacts or /property_contacts.json
  def index
    @property_contacts = @property.property_contacts
    @current_property_tab = :property_contacts
  end

  # GET /property_contacts/1 or /property_contacts/1.json
  def show
  end

  # GET /property_contacts/new
  def new
    @property_contact = @property.property_contacts.new
    @contacts = visible_contacts.limit(AMOUNT_OF_CONTACTS_DISPLAYED).order(updated_at: :desc)
  end

  # GET /property_contacts/1/edit
  def edit
    @contacts = @property_contact.contact
  end

  # POST /property_contacts or /property_contacts.json
  def create
    create_new_property_contact

    respond_to do |format|
      if @property_contact.save
        format.html { redirect_to property_property_contacts_path(@property), notice: 'Property contact was successfully created.' }
        format.json { render :show, status: :created, location: @property_contact }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @property_contact.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /property_contacts/1 or /property_contacts/1.json
  def update
    respond_to do |format|
      if update_new_property_contact
        format.html { redirect_to property_path(@property), notice: 'Property contact was successfully updated.' }
        format.json { render :show, status: :ok, location: @property_contact }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @property_contact.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /property_contacts/1 or /property_contacts/1.json
  def destroy
    @property_contact.destroy
    respond_to do |format|
      format.html { redirect_to @property, notice: 'Property contact was successfully destroyed.', status: :see_other }
      format.json { head :no_content }
    end
  end

  def filter
    @property_contact = @property.property_contacts.new
    @contacts = search_contacts
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.replace('results', partial: 'filtered', locals: { contacts: @contacts, property_contact: @property_contact })
      end
    end
  end

  private

  def set_property
    @property = Current.account.properties.with_archived.find(params[:property_id])
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_property_contact
    @property_contact = @property.property_contacts.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def property_contact_params
    params.require(:property_contact).permit(:property_id, :contact_id, classifications: [])
  end

  def create_new_property_contact
    ActiveRecord::Base.transaction do
      # Save the contact
      @property_contact = @property.property_contacts.create(property_contact_params.slice(:contact_id))
      @property_contact.save!

      # Save the classifications
      if property_contact_params[:classifications]
        property_contact_params[:classifications].each do |classification|
          @property_contact.classifications.create!(account: @current_agent.account, name: classification)
        end
      end
    end
    true
  rescue ActiveRecord::RecordInvalid
    Rails.logger.info 'ActiveRecord::RecordInvalid thrown with params'
    Rails.logger.info property_contact_params
    Rails.logger.info @property_contact.errors.inspect
    false
  end

  def update_new_property_contact
    ActiveRecord::Base.transaction do
      # Update the contact
      @property_contact.update!(property_contact_params.slice(:contact_id))

      # Update the classifications
      if property_contact_params[:classifications]
        # Drop all classifications and create new ones
        @property_contact.classifications.destroy_all

        property_contact_params[:classifications].each do |classification|
          @property_contact.classifications.create!(account: @current_agent.account, name: classification)
        end
      end
    end
    true
  rescue ActiveRecord::RecordInvalid
    Rails.logger.info 'ActiveRecord::RecordInvalid thrown with params'
    Rails.logger.info property_contact_params
    Rails.logger.info @property_contact.errors.inspect
    false
  end

  def set_nav_menu
    set_nav_menu_option(:properties)
  end

  def search_contacts
    visible_contacts.search(search_param)
  end

  def search_param
    params[:query]
  end

  def visible_contacts
    @current_agent.contacts.visible_by(@current_agent)
  end
end
