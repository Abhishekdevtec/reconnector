# frozen_string_literal: true

module AquityV2Services
  class CreateContactFromPerson
    def initialize(account:, person:)
      @account = account
      @person  = person
    end

    def create_contact_from_person!
      return if contact_modified_recently?

      contact.account_id     = @account.id
      contact.agent_id       = agent.id
      contact.source_id      = @person.id
      contact.email          = @person.email_address
      contact.phone          = @person.telephone_number
      contact.mobile         = @person.toll_free_number
      contact.fax            = @person.fax_number
      contact.url            = @person.web_site
      contact.registration   = @person.abn
      contact.notes          = @person.notes
      contact.share          = @person.is_shared
      contact.ews_item_id    = @person.contact_id
      contact.ews_change_key = @person.change_key
      build_contact_name(contact)
      contact.save!

      # contact.addresses.destroy_all if contact.addresses.any?
      build_physical_address(contact)
      build_postal_address(contact)

      contact.classifications.destroy_all if contact.classifications.any?
      build_classifications(contact)
    end

    private

    def contact
      @contact ||= find_or_build_contact(@person.id)
    end

    def find_or_build_contact(source_id)
      if @account.contacts.exists?(source_id: source_id)
        puts "Using existing contact #{source_id}"
        @account.contacts.find_by(source_id: source_id)
      else
        puts "Cannot find contact with interal_id #{source_id}, builing a new contact"
        build_contact
      end
    end

    def build_contact
      if @person.person_type.individual?
        Individual.new
      else
        Business.new
      end
    end

    def build_contact_name(contact)
      if contact.individual?
        contact.name = @person.person_company_name
      else
        contact.business_name = @person.person_company_name
      end
      contact
    end

    def build_physical_address(contact)
      line_1      = @person.pa_street_address
      postal_code = @person.pa_postal_zip_code
      city        = @person&.pa_suburb&.suburb_name
      state       = @person&.pa_suburb&.district&.province_state&.province_state_name
      country     = @person&.pa_suburb&.district&.province_state&.country&.country_name
      return if line_1.blank? && city.blank? && postal_code.blank?

      addr = contact.addresses.create(
        category: :physical,
        line_1: line_1,
        city: city,
        state: state,
        postal_code: postal_code,
        country: country
      )
      addr.save!
    end

    def build_postal_address(contact)
      line_1      = @person.postal_box_address
      postal_code = @person.pos_postal_zip_code
      city        = @person&.pos_suburb&.suburb_name
      state       = @person&.pos_suburb&.district&.province_state&.province_state_name
      country     = @person&.pos_suburb&.district&.province_state&.country&.country_name
      return if line_1.blank? && city.blank? && postal_code.blank?

      addr = contact.addresses.create(
        category: :postal,
        line_1: line_1,
        city: city,
        state: state,
        postal_code: postal_code,
        country: country
      )
      addr.save!
    end

    def build_classifications(contact)
      @person.person_classifications.each do |classification|
        contact.classifications.create!(account: contact.account, name: classification.classification_name)
      end
    end

    def agent
      @agent ||= @account.agents.find_by(email: @person.creator.email)
    end

    def person_modified_or_created_date
      return @person.modified_date unless @person.modified_date.nil?

      @person.created_date
    end

    def contact_modified_recently?
      return false if contact.nil? || !contact.persisted?

      contact.updated_at.after?(person_modified_or_created_date)
    end
  end
end
