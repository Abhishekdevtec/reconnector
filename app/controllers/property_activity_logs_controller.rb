class PropertyActivityLogsController < ApplicationController
  before_action :authenticate_agent!
  before_action :set_property

  # GET /properties/:property_id/property_activity_logs
  def index
    @current_property_tab = :property_activity_logs
    set_nav_menu_option(:properties)
  end

  private

  def set_property
    @property = Current.account.properties.with_archived.find(params[:property_id])
  end
end
