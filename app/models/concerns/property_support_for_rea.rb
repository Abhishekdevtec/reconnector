# frozen_string_literal: true

# app/models/concerns/property_support_for_rea.rb
module PropertySupportForRea
  extend ActiveSupport::Concern

  def uploaded_to_rea?
    self.rea_listed
  end
end
