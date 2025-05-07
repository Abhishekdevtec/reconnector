# frozen_string_literal: true

module EnquiriesHelper
    # true if the enquiry.id is present
  # in the flash[:enquiry_ids] array
  def enquiry_selected?(id)
    return false if flash[:enquiry_ids].nil?

    flash[:enquiry_ids].include?(id.to_s)
  end
end