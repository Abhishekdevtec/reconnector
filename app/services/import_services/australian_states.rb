# frozen_string_literal: true
#
# Imports States, Cities and Postal codes from
# a standard UTF-8 CSV file with the following
# headers: Pcode, Locality, State, Comment, Category
module ImportServices
  class AustralianStates
    require 'csv'

    def initialize(filename)
      @csv_filename = filename
    end

    def import
      @country = Country.find_or_create_by!(name: 'Australia')
      csv_input = File.read(@csv_filename)
      csv = CSV.parse(csv_input, encoding: 'UTF-8', headers: true)
      csv.each do |row|
        create_city_unless_exists(@country, row)
      end
    end

    private

    def create_city_unless_exists(country, hash)
      return if country.nil?

      state = country.states.find_by(abbreviation: hash['State'])
      puts "Cannot find state #{hash['State']}" if state.nil?

      state.cities.create!(
        name:        hash['Locality'],
        postal_code: hash['Pcode']
      ) unless state.cities.exists?(name: hash['Locality'], postal_code: hash['Pcode'])
    end
  end
end
