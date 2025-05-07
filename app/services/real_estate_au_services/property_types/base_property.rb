# frozen_string_literal: true

module RealEstateAuServices
  module PropertyTypes
    # A base Property module to create
    # child classes which implement
    # the RealEstate.com.au API for uploading,
    # updating and removing listings.
    #
    # See https://partner.realestate.com.au/documentation/api/listings/specifications/#functional-elements
    module BaseProperty
      include ActionView::Helpers::NumberHelper

      # Pass in a Property
      def initialize(property)
        @property = property
      end

      def new_listing_as_xml
        builder = Nokogiri::XML::Builder.new do |xml|
          xml.propertyList(date: format_date_time, companyName: company_name) {
            xml.send(tag_name, modTime: format_date_time(@property.updated_at), status: 'current') {
              property_elements(xml)
            }
          }
        end
        builder.to_xml
      end

      # Builds a REA XML document
      # to remove a listing
      # See https://partner.realestate.com.au/documentation/api/listings/examples/
      def destroy_listing_as_xml
        builder = Nokogiri::XML::Builder.new do |xml|
          xml.propertyList(date: format_date_time, companyName: company_name) {
            xml.send(tag_name, modTime: format_date_time(@property.updated_at), status: 'withdrawn') {
              xml.agentID @property.agent.rea_agent_id
              xml.uniqueID @property.internal_id
            }
          }
        end
        builder.to_xml
      end

      private

      def tag_name
        raise 'NotImplmented' # Code should be overriden by a child class
      end

      def company_name
        @company_name ||= @property.agent.account.company_name
      end

      def format_date_time(date_time = Time.now)
        date_time.strftime("%F-%T")
      end

      def property_elements(_xml)
        raise 'NotImplmented' # Code should be overriden by a child class
      end

      def agent_id(xml)
        xml.agentID @property.agent.rea_agent_id
      end

      def unique_id(xml)
        xml.uniqueID @property.internal_id
      end

      def miniweb(xml)
        xml.miniweb {
          xml.uri(id: 1) {
            xml.text @property.website_url || 'https://griffinproperty.com.au/properties'
          }
        }
      end

      # https://partner.realestate.com.au/documentation/api/listings/elements/#img
      def property_images(xml)
        # A minimum of 1 image must be supplied
        # with every listing, with the id of 'm' (representing the main image).
        # A total of 35 images can be supplied;
        # the id attributes must be in the range 'a' to 'z' (and if more than 25 images), 'aa' to 'ai'.
        image_ids = %w[m a b c d e f g h i j k l n o p q r s t u v w x y z aa ab ac ad ae af ag ah ai]

        @property.images.each_with_index do |image, i|
          url = AppServices::ActiveStorage::UrlHelper.image_url(image)
          # url = if Rails.env.production?
          #         # TO DO : FIX FIX FIX URL which breaks in Production
          #         # image.url
          #         # ['http://143.198.148.172', Rails.application.routes.url_helpers.rails_blob_path(image, only_path: true)].join('')
          #         Rails.application.routes.url_helpers.rails_blob_path(image)
          #       else
          #         # Rails.application.routes.url_helpers.rails_blob_path(image, only_path: true)
          #         # ['http://143.198.148.172', Rails.application.routes.url_helpers.rails_blob_path(image, only_path: true)].join('')

          #         # send a random photo from Usplash
          #         'https://unsplash.com/photos/FV3GConVSss/download?ixid=MnwxMjA3fDB8MXxhbGx8fHx8fHx8fHwxNjQyNDg2Mzg3&force=true&w=1920'
          #       end
          xml.img(id: image_ids[i], modTime: format_date_time(image.created_at), url: url, format: image.filename.extension)
        end
        xml
      end
    end
  end
end
