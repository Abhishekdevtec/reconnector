# frozen_string_literal: true

module Console::ContactsHelper
  def synchronized_with_microsoft_graph_label(contact)
    return nil if contact.nil?

    if !contact.synchronize_with_office_online?
      render BadgeComponent.new(text: 'N/A', color: :gray)
    elsif contact.synchronize_with_office_online?
      render BadgeComponent.new(text: 'Yes', color: :green)
    else
      render BadgeComponent.new(text: 'No', color: :red)
    end
  end
end
