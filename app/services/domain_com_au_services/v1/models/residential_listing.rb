# frozen_string_literal: true

# See https://developer.domain.com.au/docs/v1/getting-started
module DomainComAuServices
  module V1
    module Models
      # Model which converts a Property (type Residential)
      # to a Domain.com.au residential property in
      # order to upload it.
      #
      # See: https://developer.domain.com.au/docs/v1/apis/pkg_listing_management/references/listings_upsertresidentiallisting
      class ResidentialListing
        def initialize(property)
          @property = property
        end

        def as_json
          property_params.to_json
        end

        private

        def property_params
          params = {
            # 'occupancyType': '', # WE DON'T HAVE THIS DATA
            'listingAction': listing_action,
            'contactPreference': 'byPhone',
            # 'annualReturn': 0, # QUESTION: What value do I put in here? WE DON'T HAVE THIS DATA
            # 'unitsOffered': 1, # WE DON'T HAVE THIS DATA
            'nabers': @property.rating.to_f,
            'highlights': [], # TODO : Figure out what highlights are...
            'underOfferOrContract': false, # QUESTION: What value do I put in here?
            'domainAgencyID': @property.agent.domain_com_au_agency_id.to_i,
            'providerAdId': @property.internal_id,
            'features': @property.keywords, # Comma-separated list of features. 1000 characters in length. Select as appropriate or write your own.
            'description': @property.website_description.to_plain_text || @property.brochure_description.to_plain_text, # Use the features field which is richer
            'summary': @property.headline,
            'receiveEmailsToDefaultAddress': true, # QUESTION: Do we send to default (Agency) address? SEND TO ENQUIRIES AT THE MOMENT
            'isRural': @property.usages.include?('rural') # QUESTION: Is rural the only 'rural' value? What about farming for example?
          }
          params.merge!(price) if @property.contract.present?
          params.merge!(lease) if @property.contract.for_lease? # FIX: This causes an invalid body over at Domain.com.au ??
          params.merge!(eoi) if @property.contract.eoi_close_on.present?
          # params.merge!(tenant) # DON't SEND THIS DATA
          # params.merge!(tender) # DON't SEND THIS DATA
          # params.merge!(unit_details) # WE DON'T SEND THIS DATA
          params.merge!(sales_terms) if @property.contract.for_sale?
          params.merge!(auction) if @property.contract.sale_auction_date.present?
          params.merge!(property_details)
          params.merge!(domain_ad_id) if @property.domain_com_au_listing_id.present?
          # params.merge!(inspection_details) # DON't SEND THIS DATA
          params.merge!(media) # if @property.images.count.positive?
          params.merge!(contacts)
          params.merge!(other_enquiry_email) if @property.account.email.present?
          # TODO : Add supplementary section

          params
        end

        def listing_action
          if @property.contract.for_sale? && @property.contract.for_lease?
            'saleAndLease'
          elsif @property.contract.for_sale? && @property.contract.not_for_lease?
            'sale'
          elsif @property.contract.not_for_sale? && @property.contract.for_lease?
            'rent'
          end
        end

        def price
          from = @property.contract.sale_price_from || @property.contract.sale_price
          to   = @property.contract.sale_price_to || @property.contract.sale_price

          if @property.contract.for_lease?
            from = @property.contract.lease_total_net_rent
            to   = @property.contract.lease_total_net_rent
          end
          {
            'price': {
              'priceUnitType': 'TotalAmount',
              'priceType': 'gross',
              'gstOptionType': 'ex',
              # 'priceReduction': false, # DO NOT SEND SINCE WE DON'T HAVE THE DATA
              'displayText': 'Contact the agent',
              # 'from': from.to_f,
              # 'to': to.to_f
              'from': 0,
              'to': 0
            }
          }
        end

        def lease
          {
            'lease': {
              # 'termOfLeaseFrom': 0, # QUESTION: What value do I put here (Integer value of lease term range from)
              # 'termOfLeaseTo': 0, # QUESTION: What value do I put here (Integer value of lease term range to)
              # 'leaseOutgoings': @property.contract.lease_total_outgoings.to_f
              'leaseOutgoings': 0
            }
          }
        end

        def eoi
          {
            'eoi': {
              # 'address': , # We don't have this information in Aquity V3
              'endDate': @property.contract.eoi_close_on.strftime('%FT%X'),
              'recipientName': @property.agent.name
            }
          }
        end

        def tenant
          { # QUESTION: What values should I put in here? DON'T SEND THIS DATA
            'tenant': {
              # 'leaseStart': ,
              # 'leaseEnd': ,
              # 'name': ,
              # 'rentalDetails': ,
              # 'leaseOptions': ,
              # 'tenantInfoTermOfLeaseFrom': ,
              # 'tenantInfoTermOfLeaseTo': ,
              # 'leaseDateVariable': ,
            }
          }
        end

        def tender
          { # QUESTION: What values should I put in here?
            'tender': {
              # 'recipientName': '',
              # 'address': '',
              # 'endDate': '',
            }
          }
        end

        def unit_details
          # arr = []
          # arr << for_sale_unit_details if @property.contract.for_sale?
          # arr << for_lease_unit_details if @property.contract.for_lease?
          # {
          #   'unitDetails': arr
          # }
        end

        def for_sale_unit_details
          {
            'occupancy': 'tenanted', # QUESTION: What value should I put in here? Occupancy type : [ tenanted, vacant ]
            'priceUnit': 'totalAmount', # [ totalAmount, perSqm ]
            'name': 0, # QUESTION: What value should I put in here?
            'size': 0, # QUESTION: What value should I put in here?
            'price': @property.contract.sale_price, # QUESTION: What would the unit price be??
            'notes': '', # QUESTION: What value should I put in here?
            'isSoldOrLeased': false, # Is it [no longer] available?
            'leasePriceForSaleorLease': @property.contract.sale_price
          }
        end

        def for_lease_unit_details
          {
            'occupancy': 'tenanted', # QUESTION: What value should I put in here? Occupancy type : [ tenanted, vacant ]
            'priceUnit': 'totalAmount', # [ totalAmount, perSqm ]
            'name': 0, # QUESTION: What value should I put in here?
            'size': 0, # QUESTION: What value should I put in here?
            'price': @property.contract.lease_total_net_rent, # QUESTION: What would the unit price be??
            'notes': '', # QUESTION: What value should I put in here?
            'isSoldOrLeased': false, # Is it [no longer] available?
            'leasePriceForSaleorLease': @property.contract.lease_total_net_rent
          }
        end

        def sales_terms
          { # QUESTION: What information do I put in here?
            'salesTerms': 'Information relating to aspects of the sale, such as required deposit, settlement time. Up to 50 characters, optional. Ignored for lease listings'
          }
        end

        def auction
          {
            'auction': {
              'dateTime': @property.contract.sale_auction_date.strftime('%FT%X'),
              'location': @property.contract.sale_auction_venue
            }
          }
        end

        def property_details
          details = {
            # 'buildingType': 'whole', # QUESTION: What value do I put in here? NO, WE DON'T HAVE IT
            # 'isMarkedForLiveability': false, # QUESTION: Is false the correct value in all cases? NO, WE DON'T HAVE IT
            'propertyName': @property.name,
            'location': @property.city,
            'images': photograph_entries
          }
          details.merge!(property_types) if @property.usages.count.positive?
          details.merge!(parking) if @property.parking_spaces?
          # TODO : Add pdfs section
          details.merge!(address)
          details.merge!(area) if @property.building_area&.positive?
          details.merge!(land_area) if @property.land_area&.positive?

          { 'propertyDetails': details }
        end

        # Domain.com.au accepted values:
        # [ aquaculture, dairyFarming, developmentLand, fishingForestry, hotelLeisure, industrialWarehouse, irrigationServices, livestock, internationalCommercial, medicalConsulting, offices, parkingCarSpace, retail, ruralCommercialFarming, showroomsBulkyGoods, servicedOffices, other, cropping, viticulture, mixedFarming, grazing, horticulture, equine, farmlet, orchard, ruralLifestyle ]
        # See https://developer.domain.com.au/docs/v1/apis/pkg_listing_management/references/listings_upsertcommerciallisting
        def property_types
          arr = []
          @property.usages.each do |usage|
            # farming land_development hotel warehouse medical offices retail_store showrooms other
            # other farming development warehouse medical offices retail_store showrooms land acreage rural
            # other house unit townhouse apartment flat studio villa land acreage rural retirement service_apartment
            case usage
            when 'land_development'
              arr << 'developmentLand'
            when 'hotel'
              arr << 'hotelLeisure'
            when 'warehouse'
              arr << 'industrialWarehouse'
            when 'medical'
              arr << 'medicalConsulting'
            when 'offices'
              arr << 'offices'
            when 'retail_store'
              arr << 'retail'
            when 'showrooms'
              arr << 'showroomsBulkyGoods'
            when 'other'
              arr << 'other'
            end
          end

          if arr.length.positive?
            {
              'propertyType': arr
            }
          else
            nil
          end
        end

        def parking
          {
            'parking': {
              'parkingType': 'onSite',
              'numberOnSite': @property.parking_spaces,
              'information': @property.parking_comments
            }
          }
        end

        def domain_ad_id
          {
            'domainAdId': @property.domain_com_au_listing_id
          }
        end

        def media
          {
            'media': media_entries
          }
        end

        # TODO : FIX IMAGE URL !!!!
        def media_entries
          arr = []
          arr << website_url_media_entry
          arr += photograph_entries
          arr
        end

        def photograph_entries
          arr = []
          @property.images.each do |image|
            obj = {
              'resourceType': 'photograph',
              # 'url': ['http://143.198.148.172', Rails.application.routes.url_helpers.rails_blob_path(image, only_path: true)].join('')
              url: AppServices::ActiveStorage::UrlHelper.image_url(image)
            }
            arr << obj
          end
          arr
        end

        def website_url_media_entry
          {
            'resourceType': 'webLink',
            'url': @property.website_url || 'https://griffinproperty.com.au/properties'
          }
        end

        def contacts
          {
            'contacts': [
              {
                'domainAgentId': @property.agent.domain_com_au_agent_id,
                'firstName': @property.agent.first_name,
                'lastName': @property.agent.last_name,
                'phone': @property.agent.phone,
                'fax': @property.agent.fax || @property.account.fax,
                'mobile': @property.agent.mobile,
                'email': @property.agent.email,
                'receiveEmails': true
              }
            ]
          }
        end

        def other_enquiry_email
          {
            'otherEnquiryEmail': @property.account.email
          }
        end

        def address
          {
            'address': {
              'displayOption': 'suburbOnly', # QUESTION: What granularity to display the properties location at : [ unspecified, fullAddress, streetAndSuburb, suburbOnly, regionOnly, areaOnly, stateOnly ]
              'state': state_code(@property.state),
              'unitNumber': @property.unit_suite_shop,
              'street': @property.street_name,
              'streetNumber': @property.street_number,
              'suburb': @property.city,
              'postcode': @property.postal_code
              # TODO: Add 'suggestedGeoLocation'
            }
          }
        end

        def area
          {
            'area': {
              'unit': 'squareMetres',
              'value': @property.building_area.to_f.round(2)
            }
          }
        end

        def land_area
          {
            'landArea': {
              'unit': 'squareMetres',
              'value': @property.land_area.to_f.round(2)
            }
          }
        end

        private

        def state_code(state)
          case state.downcase
          when 'new south wales'
            'nsw'
          when 'queensland'
            'qld'
          when 'south australia'
            'sa'
          when 'tasmania'
            'tas'
          when 'victoria'
            'vic'
          when 'western australian'
            'wa'
          when 'australian capital territory'
            'act'
          when 'northern territory'
            'nt'
          end
        end
      end
    end
  end
end
