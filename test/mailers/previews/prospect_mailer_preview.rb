# Preview all emails at http://localhost:3000/rails/mailers/prospect_mailer
class ProspectMailerPreview < ActionMailer::Preview
  def matching_property_email
    ProspectMailer.with(contact: Contact.first, property: Property.first).matching_property_email
  end
end
