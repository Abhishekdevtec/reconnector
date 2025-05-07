module Microsoft
  module Graph
    module V1
      module Models
        # Model for Microsoft's Graph Contact
        # https://learn.microsoft.com/en-us/graph/api/resources/contact?view=graph-rest-1.0
        #
        # Property 	Type 	Description
        # assistantName 	String 	The name of the contact's assistant.
        # birthday 	DateTimeOffset 	The contact's birthday. The Timestamp type represents date and time information using ISO 8601 format and is always in UTC time. For example, midnight UTC on Jan 1, 2014 is 2014-01-01T00:00:00Z
        # businessAddress 	PhysicalAddress 	The contact's business address.
        # businessHomePage 	String 	The business home page of the contact.
        # businessPhones 	String collection 	The contact's business phone numbers.
        # categories 	String collection 	The categories associated with the contact.
        # changeKey 	String 	Identifies the version of the contact. Every time the contact is changed, ChangeKey changes as well. This allows Exchange to apply changes to the correct version of the object.
        # children 	String collection 	The names of the contact's children.
        # companyName 	String 	The name of the contact's company.
        # createdDateTime 	DateTimeOffset 	The time the contact was created. The Timestamp type represents date and time information using ISO 8601 format and is always in UTC time. For example, midnight UTC on Jan 1, 2014 is 2014-01-01T00:00:00Z
        # department 	String 	The contact's department.
        # displayName 	String 	The contact's display name. You can specify the display name in a create or update operation. Note that later updates to other properties may cause an automatically generated value to overwrite the displayName value you have specified. To preserve a pre-existing value, always include it as displayName in an update operation.
        # emailAddresses 	EmailAddress collection 	The contact's email addresses.
        # fileAs 	String 	The name the contact is filed under.
        # generation 	String 	The contact's generation.
        # givenName 	String 	The contact's given name.
        # homeAddress 	PhysicalAddress 	The contact's home address.
        # homePhones 	String collection 	The contact's home phone numbers.
        # id 	String 	The contact's unique identifier. By default, this value changes when the item is moved from one container (such as a folder or calendar) to another. To change this behavior, use the Prefer: IdType="ImmutableId" header. See Get immutable identifiers for Outlook resources for more information. Read-only.
        # imAddresses 	String collection 	The contact's instant messaging (IM) addresses.
        # initials 	String 	The contact's initials.
        # jobTitle 	String 	The contact’s job title.
        # lastModifiedDateTime 	DateTimeOffset 	The time the contact was modified. The Timestamp type represents date and time information using ISO 8601 format and is always in UTC time. For example, midnight UTC on Jan 1, 2014 is 2014-01-01T00:00:00Z
        # manager 	String 	The name of the contact's manager.
        # middleName 	String 	The contact's middle name.
        # mobilePhone 	String 	The contact's mobile phone number.
        # nickName 	String 	The contact's nickname.
        # officeLocation 	String 	The location of the contact's office.
        # otherAddress 	PhysicalAddress 	Other addresses for the contact.
        # parentFolderId 	String 	The ID of the contact's parent folder.
        # personalNotes 	String 	The user's notes about the contact.
        # profession 	String 	The contact's profession.
        # spouseName 	String 	The name of the contact's spouse/partner.
        # surname 	String 	The contact's surname.
        # title 	String 	The contact's title.
        # yomiCompanyName 	String 	The phonetic Japanese company name of the contact.
        # yomiGivenName 	String 	The phonetic Japanese given name (first name) of the contact.
        # yomiSurname 	String 	The phonetic Japanese surname (last name) of the contact.
        class Contact
          attr_accessor :assistant_name, :birthday, :business_address, :business_home_page, :business_phones, :categories, :change_key, :children, :company_name, :created_date_time, :department, :display_name, :email_addresses, :file_as, :generation, :given_name, :home_address, :home_phones, :id, :im_addresses, :initials, :job_title, :last_modified_date_time, :manager, :middle_name, :mobile_phone, :nick_name, :office_location, :other_address, :parent_folder_id, :personal_notes, :photo, :profession, :spouse_name, :surname, :title, :yomi_company_name, :yomi_given_name, :yomi_surname

          def initialize(params = {})
            @assistant_name = params[:assistant_name]
            @birthday = Date.parse(params[:birthday]) if params[:birthday]
            @business_address = Microsoft::Graph::V1::Models::PhysicalAddress.new(params[:business_address]) if params[:business_address]
            @business_home_page = params[:business_home_page]
            @business_phones = params[:business_phones]
            @categories = params[:categories]
            @change_key = params[:change_key]
            @children = params[:children]
            @company_name = params[:company_name]
            @created_date_time = DateTime.parse(params[:created_date_time]) if params[:created_date_time]
            @department = params[:department]
            @display_name = params[:display_name]
            @email_addresses = build_email_addresses(params[:email_addresses]) if params[:email_addresses]
            @file_as = params[:file_as]
            @generation = params[:generation]
            @given_name = params[:given_name]
            @home_address = Microsoft::Graph::V1::Models::PhysicalAddress.new(params[:home_address]) if params[:home_address]
            @home_phones = params[:home_phones]
            @id = params[:id]
            @im_addresses = params[:im_addresses]
            @initials = params[:initials]
            @job_title = params[:job_title]
            @last_modified_date_time = DateTime.parse(params[:last_modified_date_time]) if params[:last_modified_date_time]
            @manager = params[:manager]
            @middle_name = params[:middle_name]
            @mobile_phone = params[:mobile_phone]
            @nick_name = params[:nick_name]
            @office_location = params[:office_location]
            @other_address = Microsoft::Graph::V1::Models::PhysicalAddress.new(params[:other_address]) if params[:other_address]
            @parent_folder_id = params[:parent_folder_id]
            @personal_notes = params[:personal_notes]
            @photo = Microsoft::Graph::V1::Models::ProfilePhoto.new(params[:photo]) if params[:photo]
            @profession = params[:profession]
            @spouse_name = params[:spouse_name]
            @surname = params[:surname]
            @title = params[:title]
            @yomi_company_name = params[:yomi_company_name]
            @yomi_given_name = params[:yomi_given_name]
            @yomi_surname = params[:yomi_surname]
          end

          def to_h
            hash = {}
            hash.merge!({ assistantName: @assistant_name }) if @assistant_name.present?
            hash.merge!({ birthday: @birthday.to_time.iso8601 }) if @birthday.present?
            hash.merge!({ businessAddress: @business_address.to_h }) if @business_address.present?
            hash.merge!({ businessHomePage: @business_home_page }) if @business_home_page.present?
            hash.merge!({ businessPhones: @business_phones }) if @business_phones.present?
            hash.merge!({ categories: @categories }) if @categories.present?
            hash.merge!({ changeKey: @change_key }) if @change_key.present?
            hash.merge!({ children: @children }) if @children.present?
            hash.merge!({ companyName: @company_name }) if @company_name.present?
            hash.merge!({ department: @department }) if @department.present?
            hash.merge!({ displayName: @display_name }) if @display_name.present?
            hash.merge!({ emailAddresses: @email_addresses.map { |a| a.to_h } }) if @email_addresses.present?
            hash.merge!({ fileAs: @file_as }) if @file_as.present?
            hash.merge!({ generation: @generation }) if @generation.present?
            hash.merge!({ givenName: @given_name }) if @given_name.present?
            hash.merge!({ homeAddress: @home_address.to_h }) if @home_address.present?
            hash.merge!({ homePhones: @home_phones }) if @home_phones.present?
            hash.merge!({ id: @id }) if @id.present?
            hash.merge!({ imAddresses: @im_addresses }) if @im_addresses.present?
            hash.merge!({ initials: @initials }) if @initials.present?
            hash.merge!({ jobTitle: @job_title }) if @job_title.present?
            hash.merge!({ manager: @manager }) if @manager.present?
            hash.merge!({ middleName: @middle_name }) if @middle_name.present?
            hash.merge!({ mobilePhone: @mobile_phone }) if @mobile_phone.present?
            hash.merge!({ nickName: @nick_name }) if @nick_name.present?
            hash.merge!({ officeLocation: @office_location }) if @office_location.present?
            hash.merge!({ otherAddress: @other_address.to_h }) if @other_address.present?
            hash.merge!({ parentFolderId: @parent_folder_id }) if @parent_folder_id.present?
            hash.merge!({ personalNotes: @personal_notes }) if @personal_notes.present?
            hash.merge!({ photo: @photo.to_h }) if @photo.present?
            hash.merge!({ profession: @profession }) if @profession.present?
            hash.merge!({ spouseName: @spouse_name }) if @spouse_name.present?
            hash.merge!({ surname: @surname }) if @surname.present?
            hash.merge!({ title: @title }) if @title.present?
            hash.merge!({ yomiCompanyName: @yomi_company_name }) if @yomi_company_name.present?
            hash.merge!({ yomiGivenName: @yomi_given_name }) if @yomi_given_name.present?
            hash.merge!({ yomiSurname: @yomi_surname }) if @yomi_surname.present?
            hash
          end

          # def to_h
          #   {
          #     assistantName: @assistant_name,
          #     birthday: @birthday,
          #     businessAddress: @business_address.to_h,
          #     # "businessHomePage": "string",
          #     # "businessPhones": ["string"],
          #     # "categories": ["string"],
          #     # "changeKey": "string",
          #     # "children": ["string"],
          #     # "companyName": "string",
          #     # "createdDateTime": "String (timestamp)",
          #     # "department": "string",
          #     # "displayName": "string",
          #     # "emailAddresses": [{"@odata.type": "microsoft.graph.emailAddress"}],
          #     # "fileAs": "string",
          #     # "generation": "string",
          #     # "givenName": "string",
          #     # "homeAddress": {"@odata.type": "microsoft.graph.physicalAddress"},
          #     # "homePhones": ["string"],
          #     # "id": "string (identifier)",
          #     # "imAddresses": ["string"],
          #     # "initials": "string",
          #     # "jobTitle": "string",
          #     # "lastModifiedDateTime": "String (timestamp)",
          #     # "manager": "string",
          #     # "middleName": "string",
          #     # "mobilePhone": "string",
          #     # "nickName": "string",
          #     # "officeLocation": "string",
          #     # "otherAddress": {"@odata.type": "microsoft.graph.physicalAddress"},
          #     # "parentFolderId": "string",
          #     # "personalNotes": "string",
          #     # "photo": { "@odata.type": "microsoft.graph.profilePhoto" },
          #     # "profession": "string",
          #     # "spouseName": "string",
          #     # "surname": "string",
          #     # "title": "string",
          #     # "yomiCompanyName": "string",
          #     # "yomiGivenName": "string",
          #     # "yomiSurname": "string"
          #   }.to_json
          # end

          private

          def build_email_addresses(email_addresses)
            addresses = []
            email_addresses.each do |email_address|
              addresses << Microsoft::Graph::V1::Models::EmailAddress.new({ address: email_address[:address], name: email_address[:name] })
            end
            addresses
          end
        end
      end
    end
  end
end
