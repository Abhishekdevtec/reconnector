# frozen_string_literal: true

module Account::Integrations::DomainComAu
  extend ActiveSupport::Concern

  included do
    has_many :domain_com_au_listings, through: :properties, source: :domain_com_au_listing
  end
end
