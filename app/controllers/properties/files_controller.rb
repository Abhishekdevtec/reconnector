module Properties
  class FilesController < ApplicationController
    before_action :authenticate_agent!

    def destroy
      @property = @current_agent.properties.find(params[:property_id])
      return head(:bad_request) unless @property

      @file = @property.files.find(params[:id])
      return head(:bad_request) unless @file

      @file.purge_later
      head(:no_content)
    end
  end
end
