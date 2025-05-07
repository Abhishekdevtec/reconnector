require 'csv'
require 'roo'

namespace :import do
  desc 'Import districts and cities from CSV and XLSX files'
  task locations: :environment do
    # Ensure Australia exists in the countries table
    australia = Country.find_or_create_by(name: 'Australia', country_code: 'AU')

    # First File: Excel (district_cities.xlsx)
    xlsx = Roo::Spreadsheet.open(Rails.root.join('lib/assets/data/district_cities.xlsx'))
    xlsx.each_with_pagename do |_, sheet|
      sheet.each_with_index(state_name: 'state_name', district_name: 'district_name', city_name: 'city_name', postal_code: 'postal_code') do |row, index|
        next if index == 0 || row[:city_name].blank?

        state = State.find_or_create_by(name: row[:state_name], country: australia)
        district = District.find_or_create_by(name: row[:district_name], country: australia)

        city = City.find_or_initialize_by(
          name: row[:city_name],
          postal_code: row[:postal_code],
          state: state
        )

        unless city.persisted?
          city.district = district
          city.save!
          puts "City added: #{city.name} in District: #{district.name}, State: #{state.name}"
        end
      end
    end

    # Second File: CSV (state_localities.csv)
    CSV.foreach(Rails.root.join('lib/assets/data/state_localities.csv'), headers: true) do |row|
      state = State.find_or_create_by(name: row['State'], country: australia)

      city = City.find_or_initialize_by(
        name: row['Locality'],
        postal_code: row['Pcode'],
        state: state
      )

      unless city.persisted?
        city.save!
        puts "Locality added as City: #{city.name} in State: #{state.name}"
      end
    end

    puts "✅ Import completed successfully!"
  end
end
