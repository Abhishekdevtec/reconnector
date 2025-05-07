# frozen_string_literal: true

module FileServices
  # Class which takes an array of
  # ActionDispatch::Http::UploadedFile objects
  # and copies them to a local directory
  # specified in base_path
  class SaveUploadsLocally
    def initialize(files, base_path)
      @files     = files
      @base_path = base_path
    end

    def save_files_locally
      return OpenStruct.new(saved_files?: false, local_directory: @base_path, error: 'Cannot create unique local directory') unless Dir.exist?(local_directory)

      @files.each do |file|
        source_path = file.to_path
        destination_path = File.join(@base_path, file.original_filename)
        FileUtils.copy_file(source_path, destination_path)
      end
      OpenStruct.new(saved_files?: true, local_directory: @base_path, filenames: @files.map(&:original_filename))
    rescue StandardError => e
      OpenStruct.new(saved_files?: false, local_directory: @base_path, error: e)
    end
  end
end
