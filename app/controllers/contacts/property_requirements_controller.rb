module Contacts
  class PropertyRequirementsController < ApplicationController
    include Pagy::Backend

    before_action :authenticate_agent!
    before_action :set_contact

    def index
      @property_requirements = @contact.property_requirements
    end

    def create
      @property_requirement = @contact.property_requirements.build(build_property_requirement_params)

      respond_to do |format|
        if @property_requirement.save
          format.html { redirect_to @contact, notice: 'Property requirements added' }
          format.json { render :show, status: :created, location: @contact }
        else
          # Fix this to render the contact with errors
          format.html { redirect_to @contact, status: :unprocessable_entity }
          format.json { render json: @contact.errors, status: :unprocessable_entity }
        end
      end
    end

    def show
      @property_requirement = @contact.property_requirements.find(params[:id])
      @pagy, @properties = pagy(@property_requirement.matching_properties)
      set_nav_menu_option(:contacts)
    end

    def destroy
      @contact.property_requirements.find(params[:id]).destroy
      respond_to do |format|
        format.html { redirect_to contact_property_requirements_path(@contact), notice: 'Property requirement was successfully deleted.', status: :see_other }
        format.json { head :no_content }
      end
    end

    private

    def contact_id
      params[:contact_id]
    end

    def set_contact
      @contact = @current_agent.visible_contacts.find(contact_id)
    end

    def build_property_requirement_params
      {
        property_type: property_requirement_params[:classification],
        district_id: property_requirement_params[:district_id],
        for_sale: for_sale,
        for_lease: for_lease,
        area_from: property_requirement_params[:area_from],
        area_to: property_requirement_params[:area_to],
        price_from_cents: price_from_cents,
        price_to_cents: price_to_cents,
        suburbs: suburb_params
      }
    end

    def price_from_cents
      return nil if property_requirement_params[:price_from].blank?

      property_requirement_params[:price_from].to_i * 100
    end

    def price_to_cents
      return nil if property_requirement_params[:price_to].blank?

      property_requirement_params[:price_to].to_i * 100
    end

    def for_sale
      property_requirement_params[:contract_type].include?('sale')
    end

    def for_lease
      property_requirement_params[:contract_type].include?('lease')
    end

    def property_requirement_params
      params
        .require(:property_requirement)
        .permit(
          :classification,
          :contract_type,
          :district_id,
          :area_from,
          :area_to,
          :price_from,
          :price_to,
          suburbs: []
        )
    end

    def suburb_params
      property_requirement_params[:suburbs].reject(&:empty?).map(&:to_i) if property_requirement_params[:suburbs].present?
    end
  end
end
