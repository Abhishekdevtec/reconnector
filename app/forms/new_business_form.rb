# frozen_string_literal: true

class NewBusinessForm < NewContactForm
  private

  def create_new_record
    account.businesses.new(extract_contact_params)
  end

  def save_contact
    @contact = account.businesses.create(extract_contact_params)
    add_errors(@contact.errors) if @contact.invalid?
    @contact.save!
  end

  def contact_attributes
    %i[account_id agent_id type share business_name legal_name email phone mobile fax url registration notes]
  end
end
