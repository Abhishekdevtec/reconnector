# frozen_string_literal: true

module Console
  class CountriesController < ConsoleController
    before_action :set_country, only: %i[show edit update destroy]

    def index
      @countries = Country.all
    end

    def show
    end

    # def create
    #   @country = country.new(params[:country])

    #   respond_to do |format|
    #     if @country.save
    #       format.html { redirect_to console_account_contact_path(@account, @contact), notice: "Contact was successfully updated." }
    #       format.json { render :show, status: :ok, location: @contact }
    #     else
    #       format.html { render :edit, status: :unprocessable_entity }
    #       format.json { render json: @contact.errors, status: :unprocessable_entity }
    #     end
    #   end
    # end

    # def update
    #   respond_to do |format|
    #     if @country.update
    #       format.html { redirect_to console_account_contact_path(@account, @contact), notice: "Contact was successfully updated." }
    #       format.json { render :show, status: :ok, location: @contact }
    #     else
    #       format.html { render :edit, status: :unprocessable_entity }
    #       format.json { render json: @contact.errors, status: :unprocessable_entity }
    #     end
    #   end
    # end

    # def edit
    # end

    # def destroy
    #   respond_to do |format|
    #     if @country.destroy
    #       format.html { redirect_to console_account_contacts_path(@account), notice: "Contact was successfully destroyed." }
    #       format.json { head :no_content }
    #     end
    #   end
    # end

    private

    def set_country
      @country = Country.find_by(slug: params[:id])
    end

    # Only allow a list of trusted parameters through.
    def country_params
      params.require(:country).permit(:name, :country_code)
    end
  end
end
