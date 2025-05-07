# frozen_string_literal: true

module Taggable
  extend ActiveSupport::Concern

  included do
    has_many :classifier_tags, as: :taggable, dependent: :destroy
    has_many :classifiers, through: :classifier_tags

    validates :classifier_tags, length: { maximum: 3 }
  end
end
