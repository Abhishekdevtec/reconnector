# frozen_string_literal: true

# Class which loads prospects and sets
# additional attributes which indicate
# if an email has already been sent for
# the property
module Prospects
  class BuildProspects
    def initialize(property)
      @property = property
    end

    def build_prospects
      prospects = []
      @property.prospects.each do |prospect|
        emailed_at = @property.prospect_notification_emails.find_by(contact_id: prospect.id)&.emailed_at
        prospects << OpenStruct.new(prospect.attributes.merge(emailed_at: emailed_at))
      end
      prospects
    end
  end
end
