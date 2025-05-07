# frozen_string_literal: true
class OAuthToken < ApplicationRecord
  belongs_to :tokenable, polymorphic: true

  before_save :normalize_values

  validates :access_token, :expires_at, :provider, :refresh_token, presence: true

  def expired?
    return true if expires_at.blank?

    expires_at.past?
  end

  private

  def normalize_values
    attribs = ['access_token', 'provider', 'refresh_token']
    attribs.each do |attrib|
      self[attrib] = nil if self[attrib].blank?
    end
  end
end

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
