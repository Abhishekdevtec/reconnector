namespace :import_countries do
  # Imports States, Cities and Postal codes from
  # input/country_data/source/AU_standard_postcode_file_pc001_31052021.csv
  desc 'Import State and City data for Australia'
  task australia: :environment do
    filename = Rails.root.join('input', 'country_data', 'source', 'AU_standard_postcode_file_pc001_31052021.csv')
    import_service = ImportServices::AustralianStates.new(filename)
    import_service.import
  end
end
