# frozen_string_literal: true
#
# Class which holds data
# from the 'person' table
module AquityV2
  class Person < Base
    attribute :id,                       :integer, default: nil
    attribute :person_type_id,           :integer, default: nil
    attribute :person_company_name,      :string,  default: nil
    attribute :pa_street_type_id,        :integer, default: nil
    attribute :pa_street_no,             :string,  default: nil
    attribute :pa_street_name,           :string,  default: nil
    attribute :pa_suburb_id,             :integer, default: nil
    attribute :pa_postal_zip_code,       :string,  default: nil
    attribute :box_no,                   :string,  default: nil
    attribute :post_office,              :string,  default: nil
    attribute :pos_street_type_id,       :integer, default: nil
    attribute :pos_postal_zip_code,      :string,  default: nil
    attribute :pos_suburb_id,            :integer, default: nil
    attribute :registered_business_name, :string,  default: nil
    attribute :web_site,                 :string,  default: nil
    attribute :telephone_number,         :string,  default: nil
    attribute :toll_free_number,         :string,  default: nil
    attribute :email_address,            :string,  default: nil
    attribute :fax_number,               :string,  default: nil
    attribute :notes,                    :string,  default: nil
    attribute :is_active,                :boolean, default: nil
    attribute :created_by,               :integer, default: nil
    attribute :created_date,             :date,    default: nil
    attribute :modified_by,              :integer, default: nil
    attribute :modified_date,            :date,    default: nil
    attribute :designation,              :string,  default: nil
    attribute :skype_address,            :string,  default: nil
    attribute :abn,                      :string,  default: nil
    attribute :is_record_imported,       :boolean, default: nil
    attribute :is_shared,                :boolean, default: nil
    attribute :contact_id,               :string,  default: nil
    attribute :change_key,               :string,  default: nil

    # Associations
    attr_accessor :person_type, :pa_street_type, :pa_suburb,
                  :pos_street_type, :pos_suburb, :creator,
                  :person_classifications

    # Helper method which returns a
    # human-readable street address
    def pa_street_address
      number = pa_street_no if pa_street_no.present?
      type = pa_street_type&.street_type_name if pa_street_type && pa_street_type.street_type_name.present?
      name = pa_street_name if pa_street_name.present?

      [number, type, name].compact.join(', ')
    end

    # Helper method which returns a
    # human-readable post box address
    def postal_box_address
      number = box_no if box_no.present?
      office = post_office if post_office.present?

      [number, office].compact.join(', ')
    end
  end
end
