# frozen_string_literal: true

module AquityV2Services
  class ImportPropertyImage
    def initialize(account:, property_image:)
      @account        = account
      @property_image = property_image
      @retries        = 0
    end

    def import_property_image!
      puts "Searching for property with internal_id: #{@property_image.property_id}"
      property = @account.properties.find_by(internal_id: @property_image.property_id)
      if property.nil?
        Rails.logger.error "ERROR: Property with internal_id #{@property_image.property_id} was not found."
        puts "ERROR: Property with internal_id #{@property_image.property_id} was not found."
        return
      end

      # Download the photo and add it if necessary
      if property.image_already_attached?(@property_image.file_name)
        puts "Image #{@property_image.file_name} already exists for property #{property.internal_id}"
        return
      end

      file_path = download_photo
      property.images.attach(io: File.open(file_path), filename: @property_image.file_name)
    end

    private

    def property
      @account.properties.find_by(internal_id: @property_image.property_id)
    end

    def download_photo
      begin
        base_directory = Rails.root.join('public', 'images', 'account', @account.id.to_s, *@property_image.image_file_path_partial.split('/'))
        file_path = File.join(base_directory, @property_image.file_name)
        puts "Importing property_image #{@property_image.id} for #{@property_image.property_id} from #{@property_image.image_url}"
        Rails.logger.info "Downloading image from #{@property_image.image_url} and saving it to #{file_path}"
        FileUtils.mkdir_p base_directory

        download_service = HttpServices::DownloadFile.new(url: @property_image.image_url, file_path: file_path)
        response = download_service.download_file

        if response.downloaded?
          puts "Downloaded #{@property_image.image_url} and saved to #{file_path}"
          file_path
        end
      rescue StandardError => e
        if (@retries += 1) <= retry_count
          sleep retry_delay # Wait a few seconds before trying again
          Rails.logger.info "Error downloading from #{@property_image.image_url}. Retrying to download..."
          puts "Error downloading from #{@property_image.image_url}. Retrying to download..."
          puts e.message
          retry
        else
          Rails.logger.info "Retried #{@retries} times. Cannot download #{@property_image.image_url}"
          puts "Retried #{@retries} times. Cannot download #{@property_image.image_url}"
          raise
        end
      end
    end

    def default_timeout
      10
    end

    def retry_count
      3
    end

    def retry_delay
      30
    end
  end
end
