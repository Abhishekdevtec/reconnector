# app/models/concerns/has_brochure_images.rb
# frozen_string_literal: true

# Generates resized images for brochures
module HasBrochureImages
  extend ActiveSupport::Concern

  included do
    after_save_commit :generate_brochure_images, if: :brochure_images_attached?
  end

  private

  SAFE_WAITING_PERIOD = 10.seconds

  def generate_brochure_images
    variants = %i(brochure_sm brochure_base brochure_lg)
    images.each do |image|
      variants.each do |variant|
        ActiveStorage::ProcessVariantJob.set(wait: SAFE_WAITING_PERIOD).perform_later(image.id, variant)
      end
    end
  end

  def brochure_images_attached?
    images.attached?
  end
end
