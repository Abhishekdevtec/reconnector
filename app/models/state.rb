class State < ApplicationRecord
  include NormalizeBlankValues

  validates :name, uniqueness: { scope: :country }
  validates :name, presence: true
  validates :name, length: { minimum: 2 }

  validates :abbreviation, uniqueness: { scope: :country }
  validates :abbreviation, presence: true
  validates :abbreviation, length: { minimum: 2 }

  default_scope { order(:name) }

  belongs_to :country
  has_many   :cities, dependent: :destroy
end

# == Schema Information
#
# Table name: states
#
#  abbreviation :string
#  country_id   :bigint           not null
#  created_at   :datetime         not null
#  id           :bigint           not null, primary key
#  name         :string
#  updated_at   :datetime         not null
#
# Indexes
#
#  index_states_on_abbreviation  (abbreviation)
#  index_states_on_country_id    (country_id)
#  index_states_on_name          (name)
#
