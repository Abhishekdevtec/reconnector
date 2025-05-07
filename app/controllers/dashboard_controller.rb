# frozen_string_literal: true

class DashboardController < ApplicationController
  before_action :authenticate_agent!
  before_action :set_nav_menu_option

  # GET /dashboard or /dashboard.json
  def show
    @unviewed_listing_enquiries = Current.agent.listing_enquiries.unviewed.order(created_at: :desc)
    @recent_contacts = Current.agent.recently_viewed_contacts
    @recent_properties = Current.agent.recently_viewed_properties
  end
end
