# frozen_string_literal: true

module Console
  class ContactsController < ConsoleController
    before_action :set_contact, only: %i[show edit update destroy]

    # GET /contacts or /contacts.json
    def index
      @contacts = @account.contacts.all.order(updated_at: :desc)
    end

    # GET /contacts/1 or /contacts/1.json
    def show
    end

    # GET /contacts/new
    def new
      @contact = @account.contacts.new
    end

    # GET /contacts/1/edit
    def edit
    end

    # POST /contacts or /contacts.json
    def create
      @contact = NewContactForm.new(create_contact_params)
      create_contact = ContactServices::CreateContact.new.create_contact(@contact)

      respond_to do |format|
        if create_contact.created?
          format.html { redirect_to console_account_contact_path(@account, create_contact.contact), notice: "Contact was successfully created." }
          format.json { render :show, status: :created, location: @contact }
        else
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: create_contact.contact.errors, status: :unprocessable_entity }
        end
      end
    end

    # PATCH/PUT /contacts/1 or /contacts/1.json
    def update
      contact = UpdateContactForm.new(update_contact_params)
      update_contact = ContactServices::UpdateContact.new.update_contact(contact, update_contact_params)

      respond_to do |format|
        if update_contact.updated?
          format.html { redirect_to console_account_contact_path(@account, @contact), notice: "Contact was successfully updated." }
          format.json { render :show, status: :ok, location: @contact }
        else
          format.html { render :edit, status: :unprocessable_entity }
          format.json { render json: @contact.errors, status: :unprocessable_entity }
        end
      end
    end

    # DELETE /contacts/1 or /contacts/1.json
    def destroy
      @contact.destroy
      respond_to do |format|
        format.html { redirect_to console_account_contacts_path(@account), notice: "Contact was successfully destroyed." }
        format.json { head :no_content }
      end
    end

    private

    # Use callbacks to share common setup or constraints between actions.
    def set_contact
      @contact = @account.contacts.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    # def contact_params
    #   params.require(:contact).permit(:type, :agent_id, :account_id, :share, :first_name, :last_name, :business_name, :legal_name, :job_title, :email, :phone, :mobile, :fax, :url, :registration, :notes, classifications: [])
    # end

    # def create_contact_params
    # end

    # def build_update_params
    #   contact_params.merge(contact: @contact)
    # end
  end
end
