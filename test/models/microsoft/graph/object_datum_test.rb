# == Schema Information
#
# Table name: ms_graph_object_data
#
#  change_key                          :string
#  created_at                          :datetime         not null
#  created_date_time                   :datetime
#  etag                                :string
#  id                                  :bigint           not null, primary key
#  last_modified_date_time             :datetime
#  last_received_at                    :datetime
#  last_sent_at                        :datetime
#  microsoft_graph_synchronizable_id   :bigint           not null
#  microsoft_graph_synchronizable_type :string           not null
#  object_id                           :string
#  parent_folder_id                    :string
#  updated_at                          :datetime         not null
#
# Indexes
#
#  index_ms_graph_object_data_on_microsoft_graph_synchronizable  (microsoft_graph_synchronizable_type,microsoft_graph_synchronizable_id)
#
require "test_helper"

class Microsoft::Graph::ObjectDatumTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
