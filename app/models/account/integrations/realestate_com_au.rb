# frozen_string_literal: true

module Account::Integrations::RealestateComAu
  extend ActiveSupport::Concern

  included do
    has_many :real_commercial_listings, through: :properties, source: :real_commercial_listing
  end
end
