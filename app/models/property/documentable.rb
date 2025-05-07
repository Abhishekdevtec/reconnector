# frozen_string_literal: true

# Provides the ability to export
# a property to a PDF file.
module Property::Documentable
  extend ActiveSupport::Concern

  def brochure
    @brochure ||= Property::Brochure.new(self)
  end
end
