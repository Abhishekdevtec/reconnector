# frozen_string_literal: true

module RealEstateAuServices
  module Elements
    # This element contains the contact details for a single agent that is listing the property.
    # https://partner.realestate.com.au/documentation/api/listings/elements/#listingagent
    module ListingAgent
      def listing_agent(xml)
        xml.listingAgent(id: 1, displayAgentProfile: 'yes') {
          xml.name @property.agent.name
          xml.telephone(type: 'mobile') { xml.text @property.agent.mobile } if @property.agent.mobile.present?
          xml.email @property.agent.email
        }
      end
    end
  end
end
