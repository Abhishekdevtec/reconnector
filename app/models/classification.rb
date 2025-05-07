class Classification < ApplicationRecord
  belongs_to :account
  belongs_to :classifiable, polymorphic: true, optional: true
end

# == Schema Information
#
# Table name: classifications
#
#  account_id        :bigint           not null
#  classifiable_id   :bigint
#  classifiable_type :string
#  created_at        :datetime         not null
#  id                :bigint           not null, primary key
#  name              :string
#  updated_at        :datetime         not null
#
# Indexes
#
#  index_classifications_on_account_id    (account_id)
#  index_classifications_on_classifiable  (classifiable_type,classifiable_id)
#
