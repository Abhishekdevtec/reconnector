namespace :griffinproperty_com_au do
  # Imports a JSON database from from the griffinproperty.com.au website
  #
  # source file must be in input/aquity_v2/import.json
  desc 'Import griffinproperty.com.au JSON database dump'
  task import: :environment do
    filename = Rails.root.join('input', 'griffin_property_com_au', 'import.json')
    import = GriffinPropertyComAu::JsonImport.new(filename)
    import.import_property_website_urls
  end
end
