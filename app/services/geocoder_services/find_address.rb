# frozen_string_literal: true

module GeocoderServices
  class FindAddress
    def initialize(params)
      @query           = params[:query]
      @geocoder_params = params[:geocoder_params]
    end

    def call
      if @query
        Rails.logger.info "Finding address from '#{@query}'"
        results = Geocoder.search(@query, params: @geocoder_params)
      end
    rescue SocketError => e
      # Geocoder can raise the exceptions listed at
      # https://github.com/alexreisner/geocoder#error-handling
      OpenStruct.new({ success?: false, error: e })
    else
      Rails.logger.info results.to_s
      build_response(results)
    end

    private

    def build_response(results)
      OpenStruct.new({ success?: true, payload: addresses(results)&.compact })
    end

    def addresses(results)
      results&.collect { |a| build_address(a) if valid_address?(a) }
    end

    def build_address(obj)
      OpenStruct.new(obj.data['address'].merge({ latitude: obj.data['lat'], longitude: obj.data['lon'] }))
    end

    # Return true if the object has
    # a value for road, city, state and country
    def valid_address?(address_obj)
      obj = address_obj.data['address']
      obj['road'].present? && obj['city'].present? && obj['country'].present?
    end
  end
end
