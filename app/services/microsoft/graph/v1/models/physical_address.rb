module Microsoft
  module Graph
    module V1
      module Models
        # Model for Microsoft's Graph PhysicalAddress
        # https://learn.microsoft.com/en-us/graph/api/resources/physicaladdress?view=graph-rest-1.0
        class PhysicalAddress
          def initialize(params = {})
            @city              = params[:city]
            @state             = params[:state]
            @street            = params[:street]
            @postal_code       = params[:postal_code]
            @country_or_region = params[:country_or_region]
          end

          def to_h
            hash = {}
            hash.merge!({ city: @city }) if @city.present?
            hash.merge!({ countryOrRegion: @country_or_region }) if @country_or_region.present?
            hash.merge!({ postalCode: @postal_code }) if @postal_code.present?
            hash.merge!({ state: @state }) if @state.present?
            hash.merge!({ street: @street }) if @street.present?
            hash
          end
        end
      end
    end
  end
end
