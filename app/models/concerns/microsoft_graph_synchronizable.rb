# frozen_string_literal: true

# Add associations and methods so that we can
# store Microsoft Graph Object meta data
module MicrosoftGraphSynchronizable
  extend ActiveSupport::Concern

  included do
    has_one :microsoft_object_datum, as: :microsoft_graph_synchronizable, dependent: :destroy, class_name: 'Microsoft::Graph::ObjectDatum'
  end

  def microsoft_object_datum?
    Microsoft::Graph::ObjectDatum.exists?(microsoft_graph_synchronizable_id: id, microsoft_graph_synchronizable_type: self.class.to_s)
  end

  def microsoft_object_datum_missing?
    !microsoft_object_datum?
  end
end
