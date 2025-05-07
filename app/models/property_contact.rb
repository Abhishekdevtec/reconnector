class PropertyContact < ApplicationRecord
  belongs_to :property
  belongs_to :contact
  has_many :classifications, as: :classifiable, dependent: :destroy

  validates :contact_id, uniqueness: { scope: :property_id,
    message: 'should not be a contact multiple times for the same property' }
end

# == Schema Information
#
# Table name: property_contacts
#
#  contact_id  :bigint           not null
#  created_at  :datetime         not null
#  id          :bigint           not null, primary key
#  property_id :bigint           not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_property_contacts_on_contact_id   (contact_id)
#  index_property_contacts_on_property_id  (property_id)
#
