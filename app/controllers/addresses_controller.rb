class AddressesController < ApplicationController
  before_action :authenticate_agent!
  layout false

  def states
    @country = Country.find_by(slug: params[:country])
    @states = @country.states.all.order(:name).pluck(:name, :id)
    @target = params[:target]
    respond_to do |format|
      format.turbo_stream
    end
  end

  def cities
    @state = State.find(params[:state])
    @cities = @state.cities.all.order(:name).select(:name, :postal_code, :id).collect { |c| ["#{c.name.titleize} (#{c.postal_code})", c.id] }
    @target = params[:target]
    respond_to do |format|
      format.turbo_stream
    end
  end
end
