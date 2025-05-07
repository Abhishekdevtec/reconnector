# frozen_string_literal: true

# Module which provides Accounts with the ability to
# fetch enquiries from realestate.com.au using the leads API.
# The current version is v1 and if we need to upgrade to v2
# hopefully we only need to change this file.
module Account::Integrations::RealestateComAu::Client
  extend ActiveSupport::Concern

  def realestate_com_au_client
    RealestateComAu::Api::V1::Client.new({ client_id: rea_client_id, client_secret: rea_client_secret })
  end
end
