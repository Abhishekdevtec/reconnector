module Console
  class PropertyContactsController < ConsoleController
    before_action :set_property
    before_action :set_property_contact, only: %i[show edit update destroy]

    # GET /property_contacts or /property_contacts.json
    def index
      @property_contacts = @property.property_contacts.all
    end

    # GET /property_contacts/1 or /property_contacts/1.json
    def show
    end

    # GET /property_contacts/new
    def new
      @property_contact = @property.property_contacts.new
    end

    # GET /property_contacts/1/edit
    def edit
    end

    # POST /property_contacts or /property_contacts.json
    def create
      create_new_property_contact

      respond_to do |format|
        if @property_contact.save
          format.html { redirect_to console_account_property_path(@account, @property), notice: "Property contact was successfully created." }
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
          format.html { redirect_to console_account_property_path(@account, @property), notice: "Property contact was successfully updated." }
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
        format.html { redirect_to console_account_property_path(@account, @property), notice: "Property contact was successfully destroyed." }
        format.json { head :no_content }
      end
    end

    private

    def set_property
      @property = @account.properties.find(params[:property_id])
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
            @property_contact.classifications.create!(account: @account, name: classification)
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
            @property_contact.classifications.create!(account: @account, name: classification)
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
  end
end
