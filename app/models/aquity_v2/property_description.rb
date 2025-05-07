# frozen_string_literal: true
#
# Class which holds data
# from the 'property_description' table
module AquityV2
  class PropertyDescription < Base
    attribute :property_id,                           :integer, default: nil
    attribute :property_type_id,                      :integer, default: nil
    attribute :property_usage_id,                     :integer, default: nil
    attribute :area_unit_id,                          :integer, default: nil
    attribute :office_area,                           :float,   default: nil
    attribute :office_area_in_sq_meter,               :float,   default: nil
    attribute :showroom_area,                         :float,   default: nil
    attribute :showroom_area_in_sq_meter,             :float,   default: nil
    attribute :warehouse_area,                        :float,   default: nil
    attribute :warehouse_area_in_sq_meter,            :float,   default: nil
    attribute :storage_area,                          :float,   default: nil
    attribute :storage_area_in_sq_meter,              :float,   default: nil
    attribute :production_area,                       :float,   default: nil
    attribute :production_area_in_sq_meter,           :float,   default: nil
    attribute :trading_area,                          :float,   default: nil
    attribute :trading_area_in_sq_meter,              :float,   default: nil
    attribute :land_area,                             :float,   default: nil
    attribute :land_area_in_sq_meter,                 :float,   default: nil
    attribute :land_area_desc,                        :float,   default: nil
    attribute :hard_stand_area,                       :float,   default: nil
    attribute :hard_stand_area_in_sq_meter,           :float,   default: nil
    attribute :hard_stand_yard_desc,                  :string,  default: nil
    attribute :total_floor_land_area,                 :float,   default: nil
    attribute :total_floor_land_area_in_sq_meter,     :float,   default: nil
    attribute :headline,                              :string,  default: nil
    attribute :grabline,                              :string,  default: nil
    attribute :keywords,                              :string,  default: nil
    attribute :description,                           :string,  default: nil
    attribute :features,                              :string,  default: nil
    attribute :no_of_parkings,                        :integer, default: nil
    attribute :parking_comments,                      :string,  default: nil
    attribute :fit_out,                               :string,  default: nil
    attribute :furniture,                             :string,  default: nil
    attribute :lifts_escalators_travelators,          :string,  default: nil
    attribute :clearence_unit_id,                     :integer, default: nil
    attribute :clearence_min,                         :float,   default: nil
    attribute :clearence_max,                         :float,   default: nil
    attribute :clearspan_columns,                     :integer, default: nil
    attribute :crane,                                 :string,  default: nil
    attribute :entrances_rollerdoors_containeraccess, :string,  default: nil
    attribute :zoning,                                :string,  default: nil
    attribute :disability_access,                     :boolean, default: nil
    attribute :overall_nabers_rating,                 :float,   default: nil
    attribute :notes,                                 :string,  default: nil
    attribute :lot_no,                                :string,  default: nil
    attribute :unit_suite_shop,                       :string,  default: nil
    attribute :floor_level,                           :string,  default: nil
    attribute :building,                              :string,  default: nil
    attribute :naming_rights,                         :string,  default: nil
    attribute :cost_of_naming_rights,                 :float,   default: nil
    attribute :estate_type,                           :string,  default: nil
    attribute :created_date,                          :date,    default: nil
    attribute :listed_date,                           :date,    default: nil
    attribute :local_council,                         :string,  default: nil

    # Associations
    attr_accessor :property_type, :property_usage, :area_unit, :clearence_unit
  end
end
