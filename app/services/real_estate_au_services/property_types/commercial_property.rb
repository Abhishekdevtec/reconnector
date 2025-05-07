# frozen_string_literal: true

module RealEstateAuServices
  module PropertyTypes
    # Builds a CommercialProperty object
    # which is compatible with
    # RealEstate.com.au
    # See https://partner.realestate.com.au/documentation/api/listings/specifications/#functional-elements
    class CommercialProperty
      include RealEstateAuServices::PropertyTypes::BaseProperty
      include RealEstateAuServices::Elements::Address
      include RealEstateAuServices::Elements::BuildingDetails
      include RealEstateAuServices::Elements::LandDetails
      include RealEstateAuServices::Elements::ListingAgent
      include RealEstateAuServices::Elements::PriceView
      include RealEstateAuServices::Elements::Price

      TAG_NAME = 'commercial'

      # https://partner.realestate.com.au/documentation/api/listings/elements/#commerciallistingtype
      def commercial_listing_type(xml)
        if @property.contract.for_sale? && @property.contract.for_lease?
          xml.commercialListingType(value: 'both')
        elsif @property.contract.for_sale? && @property.contract.not_for_lease?
          xml.commercialListingType(value: 'sale')
        elsif @property.contract.not_for_sale? && @property.contract.for_lease?
          xml.commercialListingType(value: 'lease')
        end
      end

      # https://partner.realestate.com.au/documentation/api/listings/elements/#commercialcategory
      def commercial_categories(xml)
        return if @property.usages.empty?

        xml.commercialCategories {
          @property.usages.each_with_index do |category, i|
            xml.commercialCategory(id: i + 1, name: commercial_category_label(category.to_sym))
          end
        }
      end

      # https://partner.realestate.com.au/documentation/api/listings/elements/#commercialrent
      def commercial_rent(xml)
        if @property.contract.for_lease?
          xml.commercialRent(tax: 'exclusive') {
            xml.text(number_with_precision(@property.contract.lease_total_gross_rent, precision: 2))
          }
        end
      end

      # https://partner.realestate.com.au/documentation/api/listings/elements/#carspaces
      def car_spaces(xml)
        xml.carSpaces @property.parking_spaces if @property.parking_spaces?
      end

      # https://partner.realestate.com.au/documentation/api/listings/elements/#outgoings
      def outgoings(xml)
        xml.outgoings(number_with_precision(@property.contract.lease_outgoings, precision: 2)) if @property.contract.for_lease?
      end

      private

      def tag_name
        TAG_NAME
      end

      def property_elements(xml)
        address(xml)
        agent_id(xml)
        unique_id(xml)
        # area(xml)
        car_spaces(xml)
        commercial_listing_type(xml)
        commercial_categories(xml)

        # QUESTION : Should authority be set for properties For Sale ? NO, WE DON'T NEED TO SEND THIS DATA
        # https://partner.realestate.com.au/documentation/api/listings/elements/#authority
        # Proposal for Aquity V3 : <authority value="sale" />
        # xml.authority(value: authority)

        # QUESTION : Should under offer be set? KEEP IT AS NO
        # https://partner.realestate.com.au/documentation/api/listings/elements/#underoffer
        # Currently in Aquity V2 : <underOffer value="" />
        # Proposal for Aquity V3 : <underOffer value="no" />
        xml.underOffer(value: 'no')

        listing_agent(xml)

        if @property.contract.present?
          # xml.price(display: 'no') {
          #   # We don't want to show the price.
          #   # We are also forced to provide a
          #   # realistic Sale Price is expected
          #   # and must be over $2900
          #   xml.text number_with_precision(2901, precision: 2)
          # }
          # xml.price number_with_precision(@property.contract.sale_actual_sale_price, precision: 2)
          price(xml)
          price_view(xml)
          commercial_rent(xml)
        end

        # https://partner.realestate.com.au/documentation/api/listings/elements/#municipality
        xml.municipality @property.local_council if @property.local_council.present?

        # TO DO for Residential
        # https://partner.realestate.com.au/documentation/api/listings/elements/#category
        # xml.category category

        xml.headline @property.headline
        xml.description @property.website_description.to_plain_text || @property.brochure_description.to_plain_text
        land_details(xml)
        building_details(xml)
        outgoings(xml)
        parking_comments(xml)
        miniweb(xml) # External URL link(s)

        if @property.images.attached?
          xml.images { property_images(xml) }
        end

        zone(xml)
      end

      # We need to return a string known by the
      # RealEstate API.
      # https://partner.realestate.com.au/documentation/api/listings/elements/#category
      def commercial_category_label(category)
        case category
        when :farming then      'Commercial Farming'
        when :development then  'Land/Development'
        when :hotel then        'Hotel/Leisure'
        when :warehouse then    'Industrial/Warehouse'
        when :medical then      'Medical/Consulting'
        when :offices then      'Offices'
        when :retail_store then 'Retail'
        when :showrooms then    'Showrooms/Bulky Goods'
        else                    'Other'
        end
      end

      # https://partner.realestate.com.au/documentation/api/listings/elements/#parkingcomments
      def parking_comments(xml)
        xml.parkingComments @property.parking_comments if @property.parking_comments.present?
      end

      # https://partner.realestate.com.au/documentation/api/listings/elements/#zone
      def zone(xml)
        xml.zone @property.zoning if @property.zoning.present?
      end
    end
  end
end
