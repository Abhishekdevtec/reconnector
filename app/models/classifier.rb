class Classifier < ApplicationRecord
  belongs_to :account

  validates :name, presence: true, length: { minimum: 2 }
  validates :name, uniqueness: { scope: :account_id }

  default_scope { order(:name) }
end

# == Schema Information
#
# Table name: classifiers
#
#  account_id :bigint           not null
#  created_at :datetime         not null
#  id         :bigint           not null, primary key
#  name       :string
#  updated_at :datetime         not null
#
# Indexes
#
#  index_classifiers_on_account_id  (account_id)
#
