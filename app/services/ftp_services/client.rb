# frozen_string_literal: true

require 'net/ftp'

module FtpServices
  class Client
    def initialize(url, username, password)
      @url = url
      @username = username
      @password = password
    end

    def upload_file(source_filepath, destination_filepath = nil)
      file_object = File.new(source_filepath)
      destination_filepath = File.basename(source_filepath) if destination_filepath.nil?
      Net::FTP.open(@url, @username, @password) do |ftp|
        ftp.putbinaryfile(file_object, destination_filepath)
      end
    end
  end
end
