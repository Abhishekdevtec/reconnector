class District < ApplicationRecord
  belongs_to :country
  has_many :cities, dependent: :nullify
end

# == Schema Information
#
# Table name: districts
#
#  country_id :bigint           not null
#  created_at :datetime         not null
#  id         :bigint           not null, primary key
#  name       :string
#  updated_at :datetime         not null
#
# Indexes
#
#  index_districts_on_country_id  (country_id)
#
