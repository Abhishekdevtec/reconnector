# frozen_string_literal: true

# Class which builds a listing payload for the GriffinProperty.com.au API
module GriffinPropertyComAu
  module Apim
    module V1
      class Listing
        def initialize(property_id)
          @property_id = property_id
        end

        def to_json
          params.to_json
        end

        private

        def params
          {
            active: true,
            agent_email: property.agent.email,
            annual_outgoings: property.contract.lease_total_outgoings,
            annual_rent: property.contract.lease_total_net_rent,
            aquity_id: property.internal_id,
            description: property.website_description.to_trix_html,
            factory_area: property.production_area,
            for_lease: property.contract.for_lease?,
            for_sale: property.contract.for_sale?,
            # gmap_viewport_ne_lat: property.gmap_viewport_ne_lat,
            # gmap_viewport_ne_lng: property.gmap_viewport_ne_lng,
            # gmap_viewport_sw_lat: property.gmap_viewport_sw_lat,
            # gmap_viewport_sw_lng: property.gmap_viewport_sw_lng,
            keywords: property.keywords,
            land_area: property.land_area,
            # latitude: property.latitude,
            level: property.floor,
            # longitude: property.longitude,
            name: property.name,
            office_area: property.office_area,
            postcode: property.postal_code,
            rental_sq_m: property.contract.lease_net_rent,
            seo_1_text: property.headline,
            seo_2_text: property.grabline,
            seo_3_text: property.keywords,
            showroom_area: property.showroom_area,
            storage_area: property.storage_area,
            street: property.number_and_street,
            suburb: property.city,
            total_floor_area: property.building_area,
            trading_area: property.trading_area,
            type: property.type_label,
            unit: property.unit_suite_shop,
            updated_at: property.updated_at,
            usage: localized_usage,
            vendor_price: property.contract.sale_actual_sale_price,
            warehouse_area: property.warehouse_area,
            zoning: property.zoning,
            photos: build_photos # Array
            # youtube_videos: property.youtube_videos, # Array
            # vr_view_photos: property.vr_view_photos # Array
          }
        end

        def build_photos
          property.images.collect { |img| AppServices::ActiveStorage::UrlHelper.image_url(img) }
        end

        def localized_usage
          usage.localized_usage
        end

        def usage
          @usage ||= Usage.new(property.usages.first)
        end

        def property
          @property ||= ::Property.find(@property_id)
        end
      end
    end
  end
end
