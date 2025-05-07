# frozen_string_literal: true

# Add associations to support the Microsoft Graph API
# which is used by agents for sending Emails and managing
# Contacts via Outlook/Exchange
module AgentSupportForMicrosoftGraph
  extend ActiveSupport::Concern

  MICROSOFT_GRAPH_PROVIDER_NAME = 'microsoft_graph'

  included do
    has_one :microsoft_graph_token, -> { where(provider: MICROSOFT_GRAPH_PROVIDER_NAME) }, as: :tokenable, dependent: :destroy, class_name: 'OAuthToken'
  end

  delegate :sends_email_via_microsoft_graph?, to: :account

  def microsoft_graph_token?
    OAuthToken.exists?(tokenable_id: id, tokenable_type: 'Agent', provider: MICROSOFT_GRAPH_PROVIDER_NAME)
  end

  def microsoft_graph_token_missing?
    !microsoft_graph_token?
  end

  def refresh_microsoft_graph_access_token
    return if microsoft_graph_token_missing?

    AppServices::Microsoft::Graph::RefreshAccessToken.new(self).refresh_access_token
  end

  def build_or_update_microsoft_graph_token(token_hash)
    if microsoft_graph_token?
      microsoft_graph_token.update(token_hash_params(token_hash))
    else
      create_microsoft_graph_token(token_hash_params(token_hash))
    end
  end

  def token_hash_params(token_hash)
    {
      access_token: token_hash['access_token'],
      expires_at: Time.now + token_hash['expires_in'].to_i.seconds,
      provider: MICROSOFT_GRAPH_PROVIDER_NAME,
      refresh_token: token_hash['refresh_token']
    }
  end

  def connected_to_microsoft_graph_as
    if microsoft_graph_token? && microsoft_graph_token.expires_at.future?
      @connected_to_microsoft_graph_as ||= microsoft_graph_client.me.user.mail
    else
      'Not Connected'
    end
  end

  def microsoft_graph_client
    @microsoft_graph_client ||= ::Microsoft::Graph::V1::Client.new(microsoft_graph_token.access_token)
  end
end
