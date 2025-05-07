class Country < ApplicationRecord
  include NormalizeBlankValues

  validates :name, uniqueness: true
  validates :name, presence: true
  validates :name, length: { minimum: 2 }

  # ISO 3166-1 alpha-2
  validates :country_code, uniqueness: true
  validates :country_code, presence: true
  validates :country_code, length: { is: 2 }

  default_scope { order(:name) }

  before_save :generate_slug

  has_many :states, dependent: :destroy

  # Return a human-friendly id
  def to_param
    slug
  end

  private

  # Generate a human-friendly slug
  def generate_slug
    self.slug = name.parameterize
  end
end

# == Schema Information
#
# Table name: countries
#
#  country_code :string
#  created_at   :datetime         not null
#  id           :bigint           not null, primary key
#  name         :string
#  slug         :string
#  updated_at   :datetime         not null
#
# Indexes
#
#  index_countries_on_name  (name)
#  index_countries_on_slug  (slug)
#
