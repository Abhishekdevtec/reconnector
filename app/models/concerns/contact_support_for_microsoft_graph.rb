# frozen_string_literal: true

module ContactSupportForMicrosoftGraph
  extend ActiveSupport::Concern

  included do
    has_one :microsoft_graph_data, as: :microsoft_graph_synchronizable, dependent: :destroy, class_name: 'Microsoft::Graph::ObjectDatum'
  end

  def microsoft_graph_data?
    Microsoft::Graph::ObjectDatum.exists?(microsoft_graph_synchronizable_id: id, microsoft_graph_synchronizable_type: 'Contact')
  end

  def microsoft_graph_data_missing?
    !microsoft_graph_data?
  end

  def build_or_update_microsoft_graph_object_data(token_hash)
    if microsoft_graph_data?
      microsoft_graph_data.update(token_hash_params(token_hash))
    else
      create_microsoft_graph_data(token_hash_params(token_hash))
    end
  end

  def synchronize_with_office_online?
    synchronize_with_office_online
  end

  def synchronized_with_microsoft_graph?
    microsoft_graph_data? && microsoft_graph_data.object_id.present?
  end

  private

  def token_hash_params(token_hash)
    {
      object_id: token_hash['id'],
      change_key: token_hash['changeKey'],
      parent_folder_id: token_hash['parentFolderId'],
      etag: token_hash['@odata.etag'],
      created_date_time: token_hash['createdDateTime'],
      last_modified_date_time: token_hash['lastModifiedDateTime'],
      last_sent_at: Time.now
    }
  end
end
