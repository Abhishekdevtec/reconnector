# frozen_string_literal: true

module Console
  class PortalListingsController < ConsoleController
    before_action :set_portal_listing, only: %i[show destroy]

    def index
      @portal_listings = @account.portal_listings.all.order(updated_at: :desc)
    end

    def show
    end

    def destroy
      @portal_listing.destroy
      respond_to do |format|
        format.html { redirect_to [:console, @account, :portal_listings], notice: "PortalListing was successfully destroyed." }
        format.json { head :no_content }
      end
    end

    private

    # Use callbacks to share common setup or constraints between actions.
    def set_portal_listing
      @portal_listing = @account.portal_listings.find(params[:id])
    end
  end
end
