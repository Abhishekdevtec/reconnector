# frozen_string_literal: true

module AquityV2Services
  class CreateProperty
    def initialize(account:, property:)
      @account  = account
      @property = property
    end

    def create_property!
      if @property.type.nil?
        if detect_property_type.nil?
          puts "Property #{@property.id} invalid (no property type). Will not import."
          return
        else
          puts "Property #{@property.id} WAS invalid (no property type) but the type was detected. Going to try import ..."
        end
      end

      property = find_or_build_property(@property.id)
      return if property.persisted? && property.updated_at.after?(property_modified_or_created_date)

      puts "Updating #{@property.id}"
      property.agent_id                     = agent.id
      property.internal_id                  = @property.id
      property.name                         = @property.propertyname
      property.street_number                = @property.street_no
      property.street_name                  = @property.street_name
      property.city                         = @property&.suburb&.suburb_name
      property.state                        = @property&.province_state&.province_state_name
      property.postal_code                  = @property.postal_zip_code
      property.country                      = @property&.country&.country_name || @property&.suburb&.district&.province_state&.country&.country_name

      property.usages                       = property_usage_as_a(@property.property_description&.property_usage&.property_usage_name)
      property.office_area                  = @property.property_description.office_area
      property.showroom_area                = @property.property_description.showroom_area
      property.warehouse_area               = @property.property_description.warehouse_area
      property.storage_area                 = @property.property_description.storage_area
      property.production_area              = @property.property_description.production_area
      property.trading_area                 = @property.property_description.trading_area
      property.land_area                    = @property.property_description.land_area
      property.land_area_description        = @property.property_description.land_area_desc
      property.hard_stand_yard_area         = @property.property_description.hard_stand_area
      property.hard_stand_yard_description  = @property.property_description.hard_stand_yard_desc
      property.headline                     = @property.property_description.headline
      property.grabline                     = @property.property_description.grabline
      property.keywords                     = @property.property_description.keywords
      property.brochure_description         = @property.property_description.description
      property.website_description          = @property.property_description.features
      property.parking_spaces               = @property.property_description.no_of_parkings
      property.parking_comments             = @property.property_description.parking_comments
      property.fit_out                      = @property.property_description.fit_out
      property.furniture                    = @property.property_description.furniture
      property.lifts_escalators_travelators = @property.property_description.lifts_escalators_travelators
      property.min_clearance_height         = @property.property_description.clearence_min
      property.max_clearance_height         = @property.property_description.clearence_max
      property.clear_span_columns           = @property.property_description.clearspan_columns
      property.crane                        = @property.property_description.crane
      property.entrances_roller_doors_container_access = @property.property_description.entrances_rollerdoors_containeraccess
      property.zoning                       = @property.property_description.zoning
      property.disability_access            = @property.property_description.disability_access
      property.rating                       = @property.property_description.overall_nabers_rating
      property.notes                        = @property.property_description.notes
      property.naming_rights                = @property.property_description.naming_rights
      property.naming_rights_cost           = @property.property_description.cost_of_naming_rights
      property.building                     = @property.property_description.building
      property.floor_level                  = @property.property_description.floor_level
      property.unit_suite_shop              = @property.property_description.unit_suite_shop
      property.estate                       = @property.property_description.estate_type
      property.lot_number                   = @property.property_description.lot_no
      property.local_council                = @property.property_description.local_council

      if property.invalid?
        puts "Property #{@property.id} invalid"
        puts property.type
        puts property.country
        pp @property.errors.full_messages
        puts '-----------------------'
        return
      end

      property.save!
      property.activity_logs.create!(account: @account, action: 'aquity_v2_import', result: 'success')
      create_contract(property)
      create_contacts(property)
    end

    private

    def find_or_build_property(internal_id)
      if @account.properties.unscoped.exists?(internal_id: internal_id)
        puts "Using existing property #{internal_id}"
        @account.properties.unscoped.find_by(internal_id: internal_id)
      else
        puts "Cannot find property with interal_id #{internal_id}, builing a new property"
        build_property
      end
    end

    def build_property
      case @property&.property_description&.property_type&.property_type_name&.downcase&.to_sym
      when :commercial
        CommercialProperty.new
      when :industrial
        IndustrialProperty.new
      when :retail
        RetailProperty.new
      else
        return detect_property_type unless detect_property_type.nil?

        puts "WARNING: Defaulting to CommercialProperty for #{@property.id} due to unknown or undefined property type."
        Rails.logger.info "WARNING: Defaulting to CommercialProperty for #{@property.id} due to unknown or undefined property type."
        CommercialProperty.new
      end
    end

    def create_contract(property)
      if @property&.contract&.nil?
        puts "No contract for property #{property.internal_id}"
        return
      end

      contract = @property.contract

      property.create_contract do |c|
        c.for_sale                           = contract.for_sale?
        c.for_lease                          = contract.for_lease?
        c.sale_price                         = contract.sale_price if contract.sale_price.present?
        c.sale_price_from                    = contract.sale_price_from if contract.sale_price_from.present?
        c.sale_price_to                      = contract.sale_price_to if contract.sale_price_to.present?
        c.sale_auction_date                  = contract.auction_date
        c.sale_auction_venue                 = contract.auction_venue
        c.sale_inspection_on                 = contract.inspection_date
        c.sale_reserve_price                 = contract.reserve_price if contract.reserve_price.present?
        c.sale_actual_sale_price             = contract.reserve_price if contract.reserve_price.present?
        c.private_treaty_minimum_price       = contract.pt_min_price if contract.pt_min_price.present?
        c.private_treaty_target_price        = contract.pt_target_price if contract.pt_target_price.present?
        c.eoi_close_on                       = contract.eoi_close_date
        c.eoi_inspection_on                  = contract.eoi_inspection_date
        c.eoi_minimum_price                  = contract.eoi_min_price if contract.eoi_min_price.present?
        c.eoi_target_price                   = contract.eoi_target_price if contract.eoi_target_price.present?
        c.lease_net_rent                     = contract.net_rent_per_area if contract.net_rent_per_area.present?
        c.lease_outgoings                    = contract.outgoings_per_area if contract.outgoings_per_area.present?
        c.lease_gross_rent                   = contract.gross_rent_per_area if contract.gross_rent_per_area.present?
        c.lease_cleaning                     = contract.cleaning_per_area if contract.cleaning_per_area.present?
        c.lease_covered_parking_space        = contract.covered_parking_space_pa if contract.covered_parking_space_pa.present?
        c.lease_on_grade_parking_space       = contract.ongrade_parking_space_pa if contract.ongrade_parking_space_pa.present?
        c.lease_other_rental_costs           = contract.other_rental_cost if contract.other_rental_cost.present?
        c.lease_commencement_on              = contract.lease_commencement
        c.lease_expires_on                   = contract.lease_expiry
        c.lease_term                         = contract.lease_terms
        c.lease_rent_review_on               = contract.rent_review_date
        c.lease_escalation_rate              = contract.escalation_rate
        c.lease_escalation_formulae          = contract.escalation_formulae
      end
      puts 'Unable to create contract for' unless property.contract.present?
    end

    def create_contacts(property)
      return if @property.contacts.nil? || @property.contacts.empty?

      Rails.logger.info "Property #{@property.id} has #{@property.contacts.count} contacts"
      @property.contacts.each { |c| Rails.logger.info c.inspect }

      @property.contacts.each do |contact|
        break if contact.person_id == 0 && contact.company_id == 0

        property_contact = Contact.find_by(source_id: contact_source_id(contact))
        if property_contact.nil?
          Rails.logger.info "ERROR: Cannot find Contact for #{@property.id}"
          raise "ERROR: Cannot find Contact for #{@property.id}"
        else
          Rails.logger.info "Found Contact for #{@property.id}"
          Rails.logger.info property_contact.inspect
        end
        new_contact = PropertyContact.find_or_create_by!(property_id: property.id, contact_id: property_contact.id)
        if new_contact.present?
          contact[:classifications].each do |cc|
            new_contact.classifications.create!(account_id: @account.id, name: cc)
          end
        else
          Rails.logger.info "Cannot create new_contact for Contact (id: #{property_contact.id})"
          Rails.logger.info @property.contacts.inspect
        end
      end
    end

    def import_photos(property)
      @property.images.each do |image|
        file_path = download_photo(image)
        property.images.attach(io: File.open(file_path), filename: image.file_name)
      end
    end

    def agent
      @agent ||= @account.agents.find_by(email: @property.user.email)
    end

    def detect_property_type
      return nil if @property.property_description.nil?

      return IndustrialProperty.new if industrial_property_attributes?
      return RetailProperty.new if retail_property_attributes?
    end

    def industrial_property_attributes?
      @property.property_description.warehouse_area > 0.0 ||
        @property.property_description.production_area > 0.0 ||
        @property.property_description.hard_stand_area > 0.0 ||
        @property.property_description.clearence_min > 0.0 ||
        @property.property_description.clearence_max > 0.0
    end

    def retail_property_attributes?
      @property.property_description.trading_area > 0.0
    end

    def contact_source_id(contact)
      if contact.person_id.positive?
        contact.person_id
      elsif contact.company_id.positive?
        contact.company_id
      end
    end

    def download_photo(property_image)
      base_directory = Rails.root.join('public', 'images', *property_image.image_file_path_partial.split('/'))
      file_path = File.join(base_directory, property_image.file_name)
      Rails.logger.info "Downloading image from #{property_image.image_url} and saving it to #{file_path}"
      FileUtils.mkdir_p base_directory

      open(file_path, 'wb') do |file|
        file.write HTTParty.get(property_image.image_url).body
      end
      file_path
    end

    # Property.usages is an array of strings
    def property_usage_as_a(category_label)
      case category_label
      when 'Commercial Farming'    then ['farming']
      when 'Land/Development'      then ['land_development']
      when 'Hotel/Leisure'         then ['hotel']
      when 'Industrial/Warehouse'  then ['warehouse']
      when 'Medical/Consulting'    then ['medical']
      when 'Offices'               then ['offices']
      when 'Retail'                then ['retail_store']
      when 'Showrooms/Bulky Goods' then ['showrooms']
      when 'Other'                 then ['other']
      else []
      end
    end

    def property_modified_or_created_date
      return @property.modified_date unless @property.modified_date.nil?

      @property.created_date
    end
  end
end
