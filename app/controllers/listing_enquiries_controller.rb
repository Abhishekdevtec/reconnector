# frozen_string_literal: true

class ListingEnquiriesController < ApplicationController
  before_action :authenticate_agent!
  before_action :set_nav_menu_option

  after_action :set_listing_enquiry_as_viewed, only: :show

  def index
    @listing_enquiries = agent_enquiries
  end

  def read
    @listing_enquiries = agent_enquiries.viewed
    render :index
  end

  def unread
    @listing_enquiries = agent_enquiries.unviewed
    render :index
  end

  def show
    @listing_enquiry = Current.agent.listing_enquiries.find(params[:id])
  end

  private

  def set_listing_enquiry_as_viewed
    @listing_enquiry.remark_as_viewed(viewer: Current.agent)
  end

  def agent_enquiries
    Current
      .agent
      .listing_enquiries
      .includes(:views)
      .order(created_at: :desc)
  end
end
