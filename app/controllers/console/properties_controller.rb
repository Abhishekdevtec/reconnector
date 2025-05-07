# frozen_string_literal: true

module Console
  class PropertiesController < ConsoleController
    before_action :set_property, only: %i[show real_estate_au edit update destroy]
    before_action :set_agent, only: :create
    before_action :create_new_property_from_params, only: :create

    # GET /properties or /properties.json
    def index
      @properties = @account.properties
                            .all
                            .includes(:contract)
                            .pluck(:internal_id, :type)
    end

    # GET /properties/1 or /properties/1.json
    def show
      respond_to do |format|
        format.html { render :show }
        format.pdf do
          @brochure = @property.brochure
          send_data(@brochure.content, filename: @brochure.filename, type: 'application/pdf', disposition: 'inline')
        end
      end
    end

    # GET /properties/1/real_estate_au.xml
    # See https://partner.realestate.com.au/documentation/api/listings/specifications/#functional-elements
    def real_estate_au
      render inline: RealEstateAuServices::Property.create(@account.properties.find(params[:id])).to_xml
    end

    # GET /properties/new
    def new
      @property = Property.new
    end

    # GET /properties/1/edit
    def edit
    end

    # POST /properties or /properties.json
    def create
      create_property = PropertyServices::CreateProperty.new.create_property(@property)

      respond_to do |format|
        if create_property.created?
          format.html { redirect_to console_account_property_path(@account, create_property.property), notice: "Property was successfully created." }
          format.json { render :show, status: :created, location: @property }
        else
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: create_property.property.errors, status: :unprocessable_entity }
        end
      end
    end

    # PATCH/PUT /properties/1 or /properties/1.json
    def update
      update_property = PropertyServices::UpdateProperty.new.update_property(@property, property_params)

      respond_to do |format|
        #if @property.update(property_params)
        if update_property.updated?
          format.html { redirect_to console_account_property_path(@account, update_property.property), notice: "Property was successfully updated." }
          format.json { render :show, status: :ok, location: @property }
        else
          format.html { render :edit, status: :unprocessable_entity }
          format.json { render json: @property.errors, status: :unprocessable_entity }
        end
      end
    end

    # DELETE /properties/1 or /properties/1.json
    def destroy
      @property.destroy
      respond_to do |format|
        format.html { redirect_to console_account_properties_path(@account), notice: "Property was successfully destroyed." }
        format.json { head :no_content }
      end
    end

    private

    # Use callbacks to share common setup or constraints between actions.
    def set_property
      @property = @account.properties.find(params[:id])
    end

    def set_agent
      @agent = Agent.find(property_params[:agent_id])
    end

    def create_new_property_from_params
      @property = @agent.properties.new(property_params)
    end

    # Only allow a list of trusted parameters through.
    def property_params
      params.require(:property).permit(:type, :agent_id, :internal_id, :unique_space_deprecated, :floor_level, :name, :building, :naming_rights, :naming_rights_cost_cents, :estate, :unit_suite_shop, :floor, :street_number, :street_name, :state, :city, :postal_code, :country, :type, :office_area, :warehouse_area, :showroom_area, :storage_area, :production_area, :trading_area, :land_area, :hard_stand_yard_area, :floor_area, :headline, :grabline, :keywords, :brochure_description, :website_description, :parking_spaces, :parking_comments, :fit_out, :furniture, :lifts_escalators_travelators, :min_clearance_height, :max_clearance_height, :clear_span_columns, :crane, :entrances_roller_doors_container_access, :zoning, :disability_access, :rating, usages: [])
    end
  end
end