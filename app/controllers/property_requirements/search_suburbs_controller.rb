# frozen_string_literal: true

module PropertyRequirements
  class SearchSuburbsController < ApplicationController
    # Only connected agents have access
    before_action :authenticate_agent!

    def create
      suburb_name = params[:suburb_name].to_s.strip

      if suburb_name.length > 0 
        @suburbs = City.where('name ILIKE ?', "%#{suburb_name}%").limit(5)
      else
        @suburbs = City.none
      end
      respond_to :turbo_stream
    end
  end
end
