# frozen_string_literal: true

module Console
  class AccessRequestsController < ConsoleController
    before_action :set_access_request, only: %i[show destroy]

    def index
      @access_requests = AccessRequest.all.order(created_at: :desc)
    end

    def show
    end

    def destroy
      @access_request.destroy
      redirect_to [:console, :access_requests], notice: 'AccessRequest was successfully destroyed.', status: :see_other
    end

    private

    # Use callbacks to share common setup or constraints between actions.
    def set_access_request
      @access_request = AccessRequest.find(params[:id])
    end
  end
end
