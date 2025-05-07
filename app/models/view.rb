class View < ApplicationRecord
  belongs_to :viewable, polymorphic: true
  belongs_to :viewed_by, class_name: 'Agent'

  validates :viewed_at, presence: true
end

# == Schema Information
#
# Table name: views
#
#  created_at    :datetime         not null
#  id            :bigint           not null, primary key
#  viewable_id   :bigint           not null
#  viewable_type :string           not null
#  viewed_at     :datetime
#  viewed_by_id  :bigint           not null
#
# Indexes
#
#  index_views_on_viewable      (viewable_type,viewable_id)
#  index_views_on_viewed_by_id  (viewed_by_id)
#
