# frozen_string_literal: true

module AquityV2Services
  class JsonDataLoader
    include Builders::Properties

    def initialize(filename)
      @filename = filename
    end

    def users
      @users ||= build_users
    end

    def suburbs
      @suburbs ||= build_suburbs
    end

    def districts
      @districts ||= build_districts
    end

    def province_states
      @province_states ||= build_province_states
    end

    def countries
      @countries ||= AquityV2::Country.from_table_data(data_table(:country))
    end

    def street_types
      @street_types ||= AquityV2::StreetType.from_table_data(data_table(:street_type))
    end

    def find_street_type_by_id(id)
      street_types.select { |t| t.id == id }.first
    end

    def find_suburb_by_id(id)
      suburbs.select { |t| t.id == id }.first
    end

    def find_district_by_id(id)
      districts.select { |t| t.id == id }.first
    end

    def find_country_by_id(id)
      countries.select { |t| t.id == id }.first
    end

    def find_user_by_id(id)
      users.select { |t| t.id == id }.first
    end

    def find_province_state_by_id(id)
      province_states.select { |t| t.id == id }.first
    end

    def user_levels
      @user_levels ||= AquityV2::UserLevel.from_table_data(data_table(:user_level))
    end

    def find_user_level_by_id(id)
      user_levels.select { |ul| ul.id == id }.first
    end

    private

    def build_suburbs
      arr = AquityV2::Suburb.from_table_data(data_table(:suburb))
      arr.each do |item|
        item.district = find_district_by_id(item.district_id)
      end
      arr
    end

    def build_districts
      arr = AquityV2::District.from_table_data(data_table(:district))
      arr.each do |item|
        item.province_state = find_province_state_by_id(item.province_state_id)
      end
      arr
    end

    def build_province_states
      arr = AquityV2::ProvinceState.from_table_data(data_table(:province_state))
      arr.each do |item|
        item.country = find_country_by_id(item.country_id)
      end
      arr
    end

    # Build an array of Aquity V2 User
    # classes with their associations.
    def build_users
      arr = AquityV2::User.from_table_data(data_table(:user))
      arr.each do |item|
        item.user_level = find_user_level_by_id(item.user_level_id)
      end
      arr
    end

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
  end
end
