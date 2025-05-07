# frozen_string_literal: true
#
# Class which holds data
# from the 'property' table
module AquityV2
  class Property < Base
    attribute :id,                    :integer, default: nil
    attribute :propertyname,          :string,  default: nil
    attribute :user_id,               :integer, default: nil
    attribute :street_no,             :string,  default: nil
    attribute :street_name,           :string,  default: nil
    attribute :suburb_id,             :integer, default: nil
    attribute :district_id,           :integer, default: nil
    attribute :province_state_id,     :integer, default: nil
    attribute :postal_zip_code,       :string,  default: nil
    attribute :country_id,            :integer, default: nil
    attribute :is_active,             :boolean, default: nil
    attribute :is_archive,            :boolean, default: nil
    attribute :created_by,            :integer, default: nil
    attribute :created_date,          :date,    default: nil
    attribute :modified_by,           :integer, default: nil
    attribute :modified_date,         :date,    default: nil
    attribute :archived_date,         :date,    default: nil
    attribute :is_record_imported,    :boolean, default: nil
    attribute :import_row_id,         :integer, default: nil
    attribute :upload_date_for_gp,    :date,    default: nil
    attribute :upload_date_for_rc,    :date,    default: nil
    attribute :upload_date_for_cv,    :date,    default: nil
    attribute :upload_date_for_cr,    :date,    default: nil
    attribute :upload_date_for_ngp,   :date,    default: nil
    attribute :upload_date_for_ncv,   :date,    default: nil

    # Associations
    attr_accessor :user,
                  :suburb,
                  :district,
                  :province_state,
                  :country,
                  :creator,
                  :property_description,
                  :contract,
                  :contacts,
                  :images

    def type
      property_description&.property_type&.property_type_name&.downcase&.to_sym
    end
  end
end
