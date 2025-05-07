# frozen_string_literal: true

module GriffinPropertyComAu
  class JsonImport
    def initialize(filename)
      @filename = filename
      @account = Account.where(company_name: 'Griffin Property').first
    end

    # Imports property website urls from the JSON file
    def import_property_website_urls
      puts "Loading properties from #{@filename}"
      properties = GriffinPropertyComAu::Property.from_table_data(data_table(:properties))
      puts "Found #{properties.count} properties"
      properties.each do |property|
        Rails.logger.info "Importing property with internal_id: #{property.aquity_id} - #{property.slug}"
        puts "Importing property with internal_id: #{property.aquity_id} - #{property.slug}"
        ::Property.where(internal_id: property.aquity_id).update!(website_url: griffin_property_url(property.slug))
      end
    end

    private

    # Returns the table with all the rows in
    # the data hash
    def data_table(table_name)
      json_data.select { |d| d['name'] == table_name.to_s }.first
    end

    def json_data
      @json_data ||= JSON.parse(file_contents)
    end

    def file_contents
      @file_contents ||= File.read(@filename)
    end

    def griffin_property_url(slug)
      "https://www.griffinproperty.com.au/properties/#{slug}"
    end
  end
end
