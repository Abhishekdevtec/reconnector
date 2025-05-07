class AddressSearchController < ApplicationController
  before_action :authenticate_agent!
  layout false

  def index
    @target = params[:target]
    results = GeocoderServices::FindAddress.new({ query: params[:address], geocoder_params: geocoder_params }).call
    @addresses = results.payload[0..search_result_limit] if results.success? && results.payload.present?
    Rails.logger.info @addresses
    respond_to do |format|
      format.turbo_stream
      format.html { head :ok }
    end
  end

  private

  def geocoder_params
    { countrycodes: country_codes }
  end

  def country_codes
    Country.all.pluck(:country_code).join(',').downcase
  end

  def search_result_limit
    10
  end
end
