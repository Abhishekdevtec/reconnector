module Properties
  class ListingsController < ::ApplicationController
    before_action :authenticate_agent!
    before_action :set_property

    def new
      AppServices::Properties::Listings::CreateListing.new.create_listing(platform: platform, property_id: property_id)
      redirect_to @property
    end

    def destroy
      AppServices::Properties::Listings::DestroyListing.new.destroy_listing(platform: platform, property_id: property_id)
      redirect_to(@property, status: :see_other)
    end

    private

    def property_id
      params[:id]
    end

    def set_property
      @property = @account.properties.find(property_id)
    end

    def platform
      raise 'NotImplemented'
    end
  end
end
