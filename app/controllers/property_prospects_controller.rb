class PropertyProspectsController < ApplicationController
  before_action :authenticate_agent!
  before_action :set_property

  # GET /properties/:property_id/property_prospects
  def index
    @current_property_tab = :property_prospects
    set_nav_menu_option(:properties)
  end

  private

  def set_property
    @property = Current.account.properties.with_archived.find(params[:property_id])
  end
end
