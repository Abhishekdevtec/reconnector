class PropertiesController < ApplicationController
  include Pagy::Backend
  include ActiveStorage::SetCurrent
  include SortableAttributes

  before_action :authenticate_agent!
  before_action :set_property, only: %i[real_estate_au edit update destroy unarchive]
  before_action :create_new_property_from_params, only: :create
  before_action :set_nav_menu
  before_action :set_search_path, only: %i[index show]
  before_action :set_property_classification, only: %i[new create]

  after_action :mark_property_as_viewed, only: :show, format: :html

  # GET /properties or /properties.json
  def index
    records = PropertyQuery.new.call(scoped_properties, sort_ressource_params)
    @pagy, @properties = pagy(records)
  end

  # GET /properties/1 or /properties/1.json
  def show
    @current_property_tab = :details
    @property = Current
                  .account
                  .properties
                  .with_archived
                  .includes(:rich_text_brochure_description, :rich_text_fit_out, :rich_text_furniture, :rich_text_notes, :rich_text_website_description)
                  .find(params[:id])

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

  # GET /properties/1/edit
  def edit
    redirect_to @property, notice: 'You cannot edit this property.' unless PropertiesPolicy.edit?(@property, Current.agent)
  end

  # POST /properties or /properties.json
  def create
    create_property = PropertyServices::CreateProperty.new.create_property(@property)

    if create_property.created?
      update_current_country_and_state(create_property.property.country, create_property.property.state)
      redirect_to create_property.property, notice: 'Property was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /properties/1 or /properties/1.json
  def update
    redirect_to @property, notice: 'You cannot edit this property.' unless PropertiesPolicy.update?(@property, Current.agent)

    update_property = PropertyServices::UpdateProperty.new.update_property(@property, property_params)

    if update_property.updated?
      update_current_country_and_state(update_property.property.country, update_property.property.state)
      redirect_to update_property.property, notice: 'Property was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /properties/1 or /properties/1.json
  def destroy
    if !PropertiesPolicy.destroy?(@property, Current.agent)
      redirect_to @property, notice: 'You cannot archive this property.'
      return
    end

    # We don't delete the property, we simply set the archived_at timestamp to the current time.
    archive_property = PropertyServices::ArchiveProperty.new.archive_property(@property)

    if archive_property.archived?
      redirect_to properties_path, notice: 'Property was successfully archived.', status: :see_other
    else
      redirect_to @property, notice: 'Error archiving property.', status: :unprocessable_entity
    end
  end

  def edit_multiple
    if archive_multiple? && property_ids?
      @current_agent.properties.archive_by(id: property_ids)
      notice = 'Archived multiple properties.'
    elsif restore_multiple? && property_ids?
      @current_agent.properties.unarchive_by(id: property_ids)
      notice = 'Restored multiple properties.'
    elsif upload_to_griffin_property_com_au? && property_ids?
      AppServices::Properties::Listings::CreateListing.new.create_listings(platform: :griffin_property_com_au, property_ids: property_ids)
      notice = 'Uploaded multiple properties to your website.'
    elsif upload_to_rea? && property_ids?
      AppServices::Properties::Listings::CreateListing.new.create_listings(platform: :rea, property_ids: property_ids)
      notice = 'Uploaded multiple properties to Realestate.com.au.'
    elsif upload_to_domain_com_au? && property_ids?
      AppServices::Properties::Listings::CreateListing.new.create_listings(platform: :domain_com_au, property_ids: property_ids)
      notice = 'Uploaded multiple properties to Domain.com.au.'
    end

    flash[:property_ids] = property_ids

    redirect_to properties_path, notice: notice, status: :see_other
  end

  # PATCH /properties/:id/unarchive(.:format)
  def unarchive
    unarchive_property = PropertyServices::UnarchiveProperty.new.unarchive_property(@property)

    if unarchive_property.unarchived?
      redirect_to @property, notice: 'Property was successfully unarchived.', status: :see_other
    else
      redirect_to @property, notice: 'Error unarchiving property.', status: :unprocessable_entity
    end
  end

  private

  # Override in child classes as needed
  def scoped_properties
    agent_property_ids  = Current.agent.properties.pluck(:id)
    shared_property_ids = Current.account.properties.where(share: true).pluck(:id)
    Property.where(id: [agent_property_ids + shared_property_ids].uniq).includes(:contract)
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_property
    @property = Current.account.properties.with_archived.find(params[:id])
  end

  def create_new_property_from_params
    raise NotImplementedError
  end

  # Only allow a list of trusted parameters through.
  def property_params
    params.require(:property).permit(:type, :agent_id, :internal_id, :unique_space_deprecated, :floor_level, :name, :building, :naming_rights, :naming_rights_cost_cents, :estate, :unit_suite_shop, :floor, :street_number, :street_name, :state, :city, :postal_code, :country, :type, :office_area, :warehouse_area, :showroom_area, :storage_area, :production_area, :trading_area, :land_area, :hard_stand_yard_area, :floor_area, :headline, :grabline, :keywords, :brochure_description, :website_description, :parking_spaces, :parking_comments, :fit_out, :furniture, :lifts_escalators_travelators, :min_clearance_height, :max_clearance_height, :clear_span_columns, :crane, :entrances_roller_doors_container_access, :zoning, :disability_access, :rating, usages: [], images: [])
  end

  def archive_multiple?
    params[:archive_multiple].present?
  end

  def restore_multiple?
    params[:restore_multiple].present?
  end

  def upload_to_rea?
    params[:upload_to_rea].present?
  end

  def upload_to_domain_com_au?
    params[:upload_to_domain_com_au].present?
  end

  def upload_to_griffin_property_com_au?
    params[:upload_to_griffin_property_com_au].present?
  end

  def property_ids
    params[:property_ids]&.uniq
  end

  def property_ids?
    property_ids&.length&.positive?
  end

  def set_search_path
    @search_path = search_properties_path
    @search_placeholder = 'Search properties by ID, street, suburb or postal code'
  end

  # Sets up view components used in the
  # Property#new page
  def set_property_classification
    @property_classifications = []
    @property_classifications << PropertyClassificationComponent.new(name: 'Commercial', url: new_commercial_property_path, active: controller_classified_as?('commercial'))
    @property_classifications << PropertyClassificationComponent.new(name: 'Industrial', url: new_industrial_property_path, active: controller_classified_as?('industrial'))
    @property_classifications << PropertyClassificationComponent.new(name: 'Residential', url: new_residential_property_path, active: controller_classified_as?('residential'))
    @property_classifications << PropertyClassificationComponent.new(name: 'Retail', url: new_retail_property_path, active: controller_classified_as?('retail'))
  end

  def controller_classified_as?(str)
    controller_name.include?(str)
  end

  def update_current_country_and_state(country, state)
    @current_agent.update_current_country(country)
    @current_agent.update_current_state(state)
  end

  # Override in child classes IF needed
  def set_nav_menu
    set_nav_menu_option(:properties)
  end

  # Update the last viewed at timestamp
  def mark_property_as_viewed
    @property.remark_as_viewed(viewer: Current.agent, delete_old: true)
  end
end
