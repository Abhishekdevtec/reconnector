# frozen_string_literal: true

module AppServices
  module ActiveStorage
    class UrlHelper
      def self.image_url(image)
        if Rails.env.production?
          # TO DO : FIX FIX FIX URL which breaks in Production
          # image.url
          # ['http://143.198.148.172', Rails.application.routes.url_helpers.rails_blob_path(image, only_path: true)].join('')
          Rails.application.routes.url_helpers.rails_blob_url(image)
        else
          # Rails.application.routes.url_helpers.rails_blob_path(image, only_path: true)
          # ['http://143.198.148.172', Rails.application.routes.url_helpers.rails_blob_path(image, only_path: true)].join('')

          # send a random photo from Usplash
          'https://unsplash.com/photos/FV3GConVSss/download?ixid=MnwxMjA3fDB8MXxhbGx8fHx8fHx8fHwxNjQyNDg2Mzg3&force=true&w=1920'
        end
      end
    end
  end
end
