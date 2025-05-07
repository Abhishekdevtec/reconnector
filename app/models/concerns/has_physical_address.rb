# frozen_string_literal: true

module HasPhysicalAddress
  extend ActiveSupport::Concern

  included do
    has_one :physical_address, -> { where category: 'physical' }, as: :addressable, dependent: :destroy, class_name: 'PhysicalAddress'

    accepts_nested_attributes_for :physical_address, reject_if: :all_blank, update_only: true
  end
end
