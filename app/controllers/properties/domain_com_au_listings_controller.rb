module Properties
  class DomainComAuListingsController < ListingsController
    # GET /properties/1/domain_com_au_listing.json
    def show
      render inline: DomainComAuServices::V1::Models::Listing.create(@property).as_json
    end

    private

    def platform
      :domain_com_au
    end
  end
end
