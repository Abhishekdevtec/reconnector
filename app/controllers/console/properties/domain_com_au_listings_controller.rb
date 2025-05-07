module Console
  module Properties
    class DomainComAuListingsController < Console::PropertiesController
      # GET console/account/:account_id/properties/:id/domain_com_au_listing.json
      def show
        render inline: DomainComAuServices::V1::Models::Listing.create(@property).as_json
      end
    end
  end
end
