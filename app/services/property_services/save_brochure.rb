# frozen_string_literal: true

module PropertyServices
  # Saves a property brochure as a PDF file
  class SaveBrochure
    def initialize(directory, property_id)
      @directory   = directory
      @property_id = property_id
    end

    def save_brochure
      if property
        # brochure = PropertyServices::Brochure.new(property)
        brochure = property.brochure
        filepath = brochure.save_pdf_in(@directory)
        OpenStruct.new(saved?: true, filepath: filepath)
      else
        OpenStruct.new(saved?: false, error: "Cannot find Property with id #{@property_id}")
      end
    # rescue StandardError => e
    #   OpenStruct.new(saved?: false, error: e)
    end

    private

    def property
      @property || Property.find(@property_id)
    end
  end
end
