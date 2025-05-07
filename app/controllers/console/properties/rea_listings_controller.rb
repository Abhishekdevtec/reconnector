module Console
  module Properties
    class ReaListingsController < Console::PropertiesController
      # GET console/account/:account_id/properties/:id/rea_listing.xml
      # See https://partner.realestate.com.au/documentation/api/listings/specifications/#functional-elements
      def show
        render inline: RealEstateAuServices::Property.create(@property).new_listing_as_xml
      end
    end
  end
end
