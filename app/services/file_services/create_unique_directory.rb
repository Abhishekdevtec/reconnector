# frozen_string_literal: true

module FileServices
  # Class which creates a unique directory
  # located in base_path
  class CreateUniqueDirectory
    def initialize(base_path)
      @base_path = base_path
      generate_unique_directory_name
    end

    def create_directory
      FileUtils.mkdir_p directory_path
      OpenStruct.new(created?: true, directory: directory_path)
    rescue StandardError => e
      OpenStruct.new(created?: false, directory: directory_path, error: e)
    end

    private

    def generate_unique_directory_name
      @unique_directory = SecureRandom.urlsafe_base64

      # Make sure the directory doesn't already exist
      generate_unique_directory_name if Dir.exist?(directory_path)
    end

    def directory_path
      File.join(@base_path, @unique_directory)
    end
  end
end
