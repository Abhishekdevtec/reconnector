# frozen_string_literal: true
#
# Class which holds data
# from the 'prospecting_screen_notes' table
module AquityV2
  class ProspectingScreenNotes < Base
    attribute :id,           :integer, default: nil
    attribute :property_id,  :integer, default: nil
    attribute :note,         :string,  default: nil
    attribute :created_by,   :integer, default: nil
    attribute :created_date, :date,    default: nil
  end
end
