# frozen_string_literal: true
#
# Class which holds data
# from the 'property_image' table
module AquityV2
  class PropertyImage < Base
    attribute :id,                 :integer, default: nil
    attribute :property_id,        :integer, default: nil
    attribute :image_file_path,    :string,  default: nil
    attribute :file_name,          :string,  default: nil
    attribute :original_file_name, :string,  default: nil
    attribute :sort_id,            :integer, default: nil

    # Helper classes
    def image_file_path_partial
      image_file_path.delete_prefix('/').delete_suffix('/')
    end

    def image_url
      [domain, image_file_path_partial, ERB::Util.url_encode(file_name)].join('/')
    end

    private

    def domain
      'https://aquityv2.griffinproperty.com.au'
    end
  end
end
