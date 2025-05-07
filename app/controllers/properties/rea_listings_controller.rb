module Properties
  class ReaListingsController < ListingsController
    # GET /properties/1/rea_listing.xml
    # See https://partner.realestate.com.au/documentation/api/listings/specifications/#functional-elements
    def show
      render inline: RealEstateAuServices::Property.create(@property).new_listing_as_xml
    end

    private

    def platform
      :rea
    end
  end
end
