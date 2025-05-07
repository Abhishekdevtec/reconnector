module Properties
  class ImagesController < ApplicationController
    before_action :authenticate_agent!

    def destroy
      @property = @current_agent.properties.find(params[:property_id])
      return head(:bad_request) unless @property

      @image = @property.images.find(params[:id])
      return head(:bad_request) unless @image

      @image.purge_later
      head(:no_content)
    end
  end
end
