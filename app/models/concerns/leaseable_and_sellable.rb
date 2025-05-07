# app/models/concerns/leaseable_and_sellable.rb
# frozen_string_literal: true

# Provides a scope and helper
# method to models that have
# for_sale and for_lease booleans
module LeaseableAndSellable
  extend ActiveSupport::Concern

  included do
    scope :for_lease,          -> { where(for_lease: true) }
    scope :for_sale,           -> { where(for_sale: true) }
    scope :for_lease_and_sale, -> { where(for_lease: true, for_sale: true) }

    def for_sale?
      for_sale
    end

    def not_for_sale?
      !for_sale
    end

    def only_for_sale?
      for_sale? && not_for_lease?
    end

    def for_lease?
      for_lease
    end

    def not_for_lease?
      !for_lease
    end

    def only_for_lease?
      for_lease? && not_for_sale?
    end

    def for_sale_and_lease?
      for_sale? && for_lease?
    end

    def lease_sale_label
      return 'For sale or lease' if for_sale? && for_lease?
      return 'For sale' if for_sale?
      return 'For lease' if for_lease?

      'None'
    end
  end
end
