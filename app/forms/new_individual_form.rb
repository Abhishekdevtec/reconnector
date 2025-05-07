# frozen_string_literal: true

class NewIndividualForm < NewContactForm
  private

  def create_new_record
    account.individuals.new(extract_contact_params)
  end

  def save_contact
    @contact = account.individuals.create(extract_contact_params)
    add_errors(@contact.errors) if @contact.invalid?
    @contact.save!
  end

  def contact_attributes
    %i[account_id agent_id type share first_name last_name business_name legal_name job_title email phone mobile fax url registration notes synchronize_with_office_online]
  end
end
