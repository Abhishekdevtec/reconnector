# frozen_string_literal: true
#
class PostalAddress < Address
  before_validation do
    self.category = Address.categories[:postal]
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
