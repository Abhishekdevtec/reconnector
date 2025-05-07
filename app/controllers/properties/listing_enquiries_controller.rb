# frozen_string_literal: true

class Properties::ListingEnquiriesController < ApplicationController
  before_action :authenticate_agent!

  def index
    @property = Property.where(id: params[:property_id]).includes(:listing_enquiries).take
    @current_property_tab = :property_listing_enquiries
  end
end
