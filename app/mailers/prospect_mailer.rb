# frozen_string_literal: true

# Emails a Contact with a property that matches
# their PropertyRequirement
class ProspectMailer < ApplicationMailer
  def matching_property_email
    @contact = params[:contact]
    @property = params[:property]
    mail(to: @contact.email, subject: 'We found a matching property that might interest you!')
  end
end
