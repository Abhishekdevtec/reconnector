module Properties
  class GriffinPropertyComAuListingsController < ListingsController
    def show
      render inline: GriffinPropertyComAu::Apim::V1::Listing.new(property_id).to_json
    end

    def destroy
      redirect_to(@property, status: :see_other)
    end

    private

    def platform
      :griffin_property_com_au
    end
  end
end
