# == Schema Information
#
# Table name: classifier_tags
#
#  classifier_id :bigint           not null
#  created_at    :datetime         not null
#  id            :bigint           not null, primary key
#  taggable_id   :bigint           not null
#  taggable_type :string           not null
#  updated_at    :datetime         not null
#
# Indexes
#
#  index_classifier_tags_on_classifier_id  (classifier_id)
#  index_classifier_tags_on_taggable       (taggable_type,taggable_id)
#
require "test_helper"

class ClassifierTagTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
