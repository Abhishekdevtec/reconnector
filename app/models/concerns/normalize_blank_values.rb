# frozen_string_literal: true

# Based on an article/mixin from
# https://westonganger.com/posts/make-values-nil-if-blank-data-normalization-in-rails
module NormalizeBlankValues
  extend ActiveSupport::Concern

  included do
    before_save :normalize_blank_values
  end

  def normalize_blank_values
    attributes.each do |column, value|
      next unless value.is_a?(String)
      next unless value.respond_to?(:present?)

      self[column].present? || self[column] = nil
    end
  end
end
