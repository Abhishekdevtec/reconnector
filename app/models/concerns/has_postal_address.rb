# frozen_string_literal: true

module HasPostalAddress
  extend ActiveSupport::Concern

  included do
    has_one :postal_address, -> { where category: 'postal' }, as: :addressable, dependent: :destroy, class_name: 'PostalAddress'

    accepts_nested_attributes_for :postal_address, reject_if: :all_blank, update_only: true
  end
end
