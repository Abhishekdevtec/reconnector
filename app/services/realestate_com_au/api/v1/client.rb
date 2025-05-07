# frozen_string_literal: true

class RealestateComAu::Api::V1::Client
  include RealestateComAu::Api::V1::FetchEnquiries
  include RealestateComAu::Api::V1::FetchListingUploadReport

  def initialize(params = {})
    @client_id     = params.fetch(:client_id)
    @client_secret = params.fetch(:client_secret)
    @access_token  = params.fetch(:access_token, nil)
  end

  def access_token
    return @access_token if @access_token.present?

    endpoint = 'https://api.realestate.com.au/oauth/token'
    options  = {
      body: { grant_type: 'client_credentials' },
      basic_auth: { username: @client_id, password: @client_secret }
    }
    response = HTTParty.post(endpoint, options)
    @access_token = JSON.parse(response.body)['access_token'] if response.code == 200
  rescue HTTParty::Error
    @access_token = nil
  end
end
