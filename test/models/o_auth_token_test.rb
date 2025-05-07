# == Schema Information
#
# Table name: o_auth_tokens
#
#  access_token   :string           not null
#  created_at     :datetime         not null
#  expires_at     :datetime         not null
#  id             :bigint           not null, primary key
#  provider       :string           not null
#  refresh_token  :string           not null
#  tokenable_id   :bigint
#  tokenable_type :string
#  updated_at     :datetime         not null
#
# Indexes
#
#  index_o_auth_tokens_on_tokenable_id    (tokenable_id)
#  index_o_auth_tokens_on_tokenable_type  (tokenable_type)
#
require 'test_helper'

class OAuthTokenTest < ActiveSupport::TestCase
  should validate_presence_of(:access_token)
  should validate_presence_of(:expires_at)
  should validate_presence_of(:provider)
  should validate_presence_of(:refresh_token)

  test 'expired helper method returns true if token expired' do
    token = o_auth_tokens(:one)
    token.expires_at = Time.now - 1.month
    assert token.expired?
  end
end
