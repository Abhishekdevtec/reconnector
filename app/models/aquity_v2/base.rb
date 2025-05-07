# frozen_string_literal: true
#
# A base Class which provides
# some low-level functions
# such as loading from a MySQL
# dump in JSON format
module AquityV2
  class Base
    include ActiveModel::Model
    include ActiveModel::Attributes

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
