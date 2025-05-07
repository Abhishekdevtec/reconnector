# frozen_string_literal: true
#
class Address < ApplicationRecord
  include NormalizeBlankValues

  belongs_to :addressable, polymorphic: true

  scope :physical, -> { where category: 'physical' }
  scope :postal,   -> { where category: 'postal' }
  scope :business, -> { where category: 'business' }
  scope :home,     -> { where category: 'home' }
  scope :work,     -> { where category: 'work' }
  scope :shipping, -> { where category: 'shipping' }
  scope :billing,  -> { where category: 'billing' }
  scope :other,    -> { where category: 'other' }

  enum category: %i[physical postal business home work shipping billing other], _default: 'physical'

  def to_s
    [line_1, line_2, line_3, city, postal_code, state, country].compact.join ', '
  end
end

# == Schema Information
#
# Table name: addresses
#
#  addressable_id   :bigint
#  addressable_type :string
#  category         :integer          default("physical")
#  city             :string
#  country          :string
#  created_at       :datetime         not null
#  id               :bigint           not null, primary key
#  line_1           :string
#  line_2           :string
#  line_3           :string
#  postal_code      :string
#  state            :string
#  updated_at       :datetime         not null
#
# Indexes
#
#  index_addresses_on_addressable  (addressable_type,addressable_id)
#
