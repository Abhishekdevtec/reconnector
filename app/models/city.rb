class City < ApplicationRecord
  include NormalizeBlankValues

  validates :name, presence: true
  validates :name, length: { minimum: 2 }

  validates :postal_code, presence: true
  validates :name, uniqueness: { scope: %i[postal_code state_id] }

  belongs_to :state
  belongs_to :district, optional: true

  def label
    "#{name} (#{postal_code})"
  end
end

# == Schema Information
#
# Table name: cities
#
#  created_at  :datetime         not null
#  district_id :bigint
#  id          :bigint           not null, primary key
#  name        :string
#  postal_code :string
#  state_id    :bigint           not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_cities_on_district_id  (district_id)
#  index_cities_on_state_id     (state_id)
#
