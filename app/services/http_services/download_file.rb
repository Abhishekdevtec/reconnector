# frozen_string_literal: true

module HttpServices
  class DownloadFile
    def initialize(url:, file_path:)
      @url = url
      @file_path = file_path
    end

    def download_file
      http_conn = Faraday.new do |builder|
        builder.adapter Faraday.default_adapter
      end

      File.open(@file_path, 'wb') do |file|
        file.write(http_conn.get(@url).body)
      end
      OpenStruct.new(downloaded?: true)
    end
  end
end
