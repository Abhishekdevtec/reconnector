# app/models/concerns/has_local_directory.rb
# frozen_string_literal: true

# Provides a helper method to models
# who need to store files in a directory
# on the server
module HasUniqueLocalDirectory
  extend ActiveSupport::Concern

  included do
    after_create_commit :create_unique_local_directory
    after_destroy_commit :delete_unique_local_directory
  end

  def unique_local_directory
    Rails.root.join('tmp', 'unique_model_directories', klass, id.to_s) if id.present?
  end

  private

  def safe_to_delete_unique_local_directory?
    Dir.exist?(unique_local_directory) &&
      unique_local_directory.to_s.start_with?(Rails.root.join('tmp', 'unique_model_directories').to_s)
  end

  def create_unique_local_directory
    FileUtils.mkdir_p(unique_local_directory)
  end

  def delete_unique_local_directory
    FileUtils.remove_dir(unique_local_directory) if safe_to_delete_unique_local_directory?
  end

  def klass
    self.class.to_s.underscore
  end
end
