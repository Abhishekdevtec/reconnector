# frozen_string_literal: true

module AquityV2Services
  class ImportDistrict
    def import_district!(district)
      country = Country.find_by!(name: district.province_state.country.country_name)
      return if District.exists?(name: district.district_name, country: country)

      District.create!(name: district.district_name, country: country)
    end
  end
end
