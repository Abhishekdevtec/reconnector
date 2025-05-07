# frozen_string_literal: true

module AquityV2Services
  class JsonImport
    def initialize(filename)
      @filename = filename
      @data = AquityV2Services::JsonDataLoader.new(@filename)
      @account = Account.where(company_name: 'Griffin Property').first
    end

    def import
      import_agents
      import_contacts
      import_districts
      import_properties
      import_property_images
      import_person_property_requirements
    end

    # To import Aquity V3 Agents,
    # we read the Aquity V2 'user' table
    # and associated 'user_level'
    def import_agents
      puts '[AquityV2Services::JsonImport] Importing agents'
      Rails.logger.info '[AquityV2Services::JsonImport] Importing agents'
      ActiveRecord::Base.transaction do
        imported_agents = 0
        @data.users.each do |user|
          AquityV2Services::CreateAgentFromUser.new(account: @account, user: user).create_agent_from_user!
          imported_agents += 1
        end
        puts "[AquityV2Services::JsonImport] Imported #{imported_agents}/#{@data.users.count} agents"
        Rails.logger.info "[AquityV2Services::JsonImport] Imported #{imported_agents}/#{@data.users.count} agents"
        true
      end
    rescue ActiveRecord::ActiveRecordError => e
      Rails.logger.info "ERROR Importing Agents from Aquity V2 dump"
      Rails.logger.info e.message
      false
    end

    def import_contacts
      puts '[AquityV2Services::JsonImport] Importing contacts'
      Rails.logger.info '[AquityV2Services::JsonImport] Importing contacts'
      ActiveRecord::Base.transaction do
        imported_contacts = 0
        @data.people.each do |person|
          AquityV2Services::CreateContactFromPerson.new(
            account: @account,
            person: person
          ).create_contact_from_person!
          imported_contacts += 1
        end
        puts "[AquityV2Services::JsonImport] Imported #{imported_contacts}/#{@data.people.count} contacts"
        Rails.logger.info "[AquityV2Services::JsonImport] Imported #{imported_contacts}/#{@data.people.count} contacts"
        true
      end
    rescue ActiveRecord::ActiveRecordError => e
      Rails.logger.info "ERROR Importing Contacts from Aquity V2 dump"
      Rails.logger.info e.message
      false
    end

    def import_properties
      ActiveRecord::Base.transaction do
        puts '[AquityV2Services::JsonImport] Importing properties'
        Rails.logger.info '[AquityV2Services::JsonImport] Importing properties'
        imported_properties = 0
        @data.properties.each do |property|
          if property.user_id.positive?
            AquityV2Services::CreateProperty.new(
              account: @account,
              property: property
            ).create_property!
            imported_properties += 1
          else
            puts "[AquityV2Services::JsonImport] Property #{property.id} user ID is #{property.user_id} and cannot import property."
            Rails.logger.info "[AquityV2Services::JsonImport] Property #{property.id} user ID is #{property.user_id} and cannot import property."
          end
        end
        puts "[AquityV2Services::JsonImport] Imported #{imported_properties}/#{@data.properties.count} properties"
        Rails.logger.info "[AquityV2Services::JsonImport] Imported #{imported_properties}/#{@data.properties.count} properties"
        true
      end
    rescue ActiveRecord::ActiveRecordError => e
      Rails.logger.info "ERROR Importing Properties from Aquity V2 dump"
      Rails.logger.info e.message
      false
    end

    def import_property_images
      puts '[AquityV2Services::JsonImport] Importing property images'
      Rails.logger.info '[AquityV2Services::JsonImport] Importing property images'
      imported_property_images = 0
      @data.property_images.each do |property_image|
        begin
          AquityV2Services::ImportPropertyImage.new(
            account: @account,
            property_image: property_image
          ).import_property_image!
          imported_property_images += 1
        rescue StandardError => e
          puts "ERROR Importing property_image #{property_image.id} for #{property_image.property_id}"
          puts e.message
          Rails.logger.info "ERROR Importing property_image #{property_image.id} for #{property_image.property_id}"
          Rails.logger.info e.message
          false
        end
      end
      puts "[AquityV2Services::JsonImport] Imported #{imported_property_images}/#{@data.property_images.count} property images"
      Rails.logger.info "[AquityV2Services::JsonImport] Imported #{imported_property_images}/#{@data.property_images.count} property images"
      true
    end

    def import_districts
      puts '[AquityV2Services::JsonImport] Importing districts'
      Rails.logger.info '[AquityV2Services::JsonImport] Importing districts'
      imported_districts = 0

      @data.districts.each do |district|
        puts "Importing #{district.district_name}"
        begin
          AquityV2Services::ImportDistrict.new.import_district!(district)
          imported_districts += 1
        rescue StandardError => e
          puts "ERROR Importing district #{district.district_name}"
          puts e.message
          Rails.logger.info "ERROR Importing district #{district.district_name}"
          Rails.logger.info e.message
          false
        end
      end

      # Link suburbs to a district
      @data.suburbs.each do |suburb|
        if suburb.district
          # puts "Linking #{suburb.suburb_name} to #{suburb.district.district_name}"
          city = City.find_by(name: suburb.suburb_name)
          if city
            city.district = District.find_by!(name: suburb.district.district_name)
            city.save!
          else
            puts "Cannot find #{suburb.suburb_name} (postal code: #{suburb.postal_zip_code})"
          end
        end
      end

      puts "[AquityV2Services::JsonImport] Imported #{imported_districts}/#{@data.districts.count} districts"
      Rails.logger.info "[AquityV2Services::JsonImport] Imported #{imported_districts}/#{@data.districts.count} districts"
      true
    end

    def import_person_property_requirements
      puts '[AquityV2Services::JsonImport] Importing person_property_requirements'
      Rails.logger.info '[AquityV2Services::JsonImport] Importing person_property_requirements'
      imported_person_property_requirements = 0

      @data.person_property_requirements.each do |person_property_requirement|
        begin
          AquityV2Services::ImportPersonPropertyRequirement.new(person_property_requirement).create_person_property_requirement!
          imported_person_property_requirements += 1
        rescue StandardError => e
          puts "ERROR Importing person_property_requirement (id #{person_property_requirement.id})"
          puts e.message
          Rails.logger.info "ERROR Importing person_property_requirement (id #{person_property_requirement.id})"
          Rails.logger.info e.message
          false
        end
      end

      puts "[AquityV2Services::JsonImport] Imported #{imported_person_property_requirements}/#{@data.person_property_requirements.count} person_property_requirements"
      Rails.logger.info "[AquityV2Services::JsonImport] Imported #{imported_person_property_requirements}/#{@data.person_property_requirements.count} person_property_requirements"
      true
    end

  end
end
