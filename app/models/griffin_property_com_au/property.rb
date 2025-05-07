# frozen_string_literal: true

# A base Class which provides
# some low-level functions
# such as loading from a MySQL
# dump in JSON format
module GriffinPropertyComAu
  class Property
    include ActiveModel::Model
    include ActiveModel::Attributes

    attribute :id,                   :integer,  default: nil
    attribute :name,                 :string,   default: nil
    attribute :description,          :string,   default: nil
    attribute :suburb_id,            :integer,  default: nil
    attribute :agent_id,             :integer,  default: nil
    attribute :unit,                 :string,   default: nil
    attribute :level,                :string,   default: nil
    attribute :street,               :string,   default: nil
    attribute :for_lease,            :boolean,  default: nil
    attribute :for_sale,             :boolean,  default: nil
    attribute :zoning,               :string,   default: nil
    attribute :land_area,            :float,    default: nil
    attribute :showroom_area,        :float,    default: nil
    attribute :trading_area,         :float,    default: nil
    attribute :office_area,          :float,    default: nil
    attribute :storage_area,         :float,    default: nil
    attribute :warehouse_area,       :float,    default: nil
    attribute :factory_area,         :float,    default: nil
    attribute :total_floor_area,     :float,    default: nil
    attribute :vendor_price,         :float,    default: nil
    attribute :annual_rent,          :float,    default: nil
    attribute :rental_sq_m,          :float,    default: nil
    attribute :annual_outgoings,     :float,    default: nil
    attribute :seo_1_text,           :string,   default: nil
    attribute :seo_2_text,           :string,   default: nil
    attribute :seo_3_text,           :string,   default: nil
    attribute :slug,                 :string,   default: nil
    attribute :usage_id,             :integer,  default: nil
    attribute :type_id,              :integer,  default: nil
    attribute :longitude,            :decimal,  default: nil
    attribute :latitude,             :decimal,  default: nil
    attribute :gmap_viewport_ne_lng, :decimal,  default: nil
    attribute :gmap_viewport_ne_lat, :decimal,  default: nil
    attribute :created_at,           :datetime, default: nil
    attribute :updated_at,           :date,     default: nil
    attribute :property,             :string,   default: nil
    attribute :keywords,             :string,   default: nil
    attribute :gmap_viewport_sw_lng, :decimal,  default: nil
    attribute :gmap_viewport_sw_lat, :decimal,  default: nil
    attribute :aquity_id,            :string,   default: nil
    attribute :aquity_v2_id,         :string,   default: nil
    attribute :active,               :boolean,  default: nil
    attribute :postcode,             :string,   default: nil
    attribute :usage_tag,            :string,   default: nil

    def self.from_json(json)
      new(json.map { |k, v| [k.downcase, v] }.to_h)
    end

    def self.from_table_data(json_data)
      return nil if json_data.nil? || json_data['data'].nil?

      objects = []
      json_data['data'].each do |entry|
        # Pass a hash to the model
        objects << new(entry.map { |k, v| [k.downcase, v] }.to_h)
      end
      objects
    end
  end
end
