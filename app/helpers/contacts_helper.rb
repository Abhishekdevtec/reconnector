module ContactsHelper
  def contact_index_tabs
    @page_tabs = []
    @page_tabs << PageTabComponent.new(name: 'All', url: contacts_path, active: controller_name == 'contacts' && params[:filter].nil?)
    @page_tabs << PageTabComponent.new(name: 'Individuals', url: individuals_path, active: controller_name == 'individuals')
    @page_tabs << PageTabComponent.new(name: 'Businesses', url: businesses_path, active: controller_name == 'businesses')
    %w(a b c d e f g h i j k l m n o p q r s t u v w x y z #).each do |filter|
      @page_tabs << PageTabComponent.new(name: filter.upcase, url: contacts_path(filter: filter.to_sym), active: params[:filter] == filter)
    end
  end

  def new_individual_button
    content_tag(:span, class: 'block') do
      link_to(new_individual_path, class: 'inline-flex items-center px-4 py-2 border border-gray-300 rounded-md shadow-sm text-sm font-medium text-gray-700 bg-white hover:bg-gray-50 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-offset-gray-50 focus:ring-purple-500', role: 'button') do
        concat '<svg xmlns="http://www.w3.org/2000/svg" class="-ml-1 mr-2 h-5 w-5 text-gray-400" fill="none" viewBox="0 0 24 24" stroke="currentColor"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 4v16m8-8H4" /></svg>'.html_safe
        concat 'New individual'
      end
    end
  end

  def new_business_button
    content_tag(:span, class: 'block') do
      link_to(new_business_path, class: 'inline-flex items-center px-4 py-2 border border-gray-300 rounded-md shadow-sm text-sm font-medium text-gray-700 bg-white hover:bg-gray-50 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-offset-gray-50 focus:ring-purple-500', role: 'button') do
        concat '<svg xmlns="http://www.w3.org/2000/svg" class="-ml-1 mr-2 h-5 w-5 text-gray-400" fill="none" viewBox="0 0 24 24" stroke="currentColor"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 4v16m8-8H4" /></svg>'.html_safe
        concat 'New business'
      end
    end
  end

  def edit_contact_button(contact)
    content_tag(:span, class: 'block') do
      link_to [:edit, contact], class: 'inline-flex items-center px-4 py-2 border border-gray-300 rounded-md shadow-sm text-sm font-medium text-gray-700 bg-white hover:bg-gray-50 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-offset-gray-50 focus:ring-purple-500', role: 'button' do
        concat '<svg class="-ml-1 mr-2 h-5 w-5 text-gray-400" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="currentColor" aria-hidden="true"><path d="M13.586 3.586a2 2 0 112.828 2.828l-.793.793-2.828-2.828.793-.793zM11.379 5.793L3 14.172V17h2.828l8.38-8.379-2.83-2.828z" /></svg>'.html_safe
        concat 'Edit'
      end
    end
  end

  def contact_shared_by_different_agent?(contact, current_agent)
    contact.agent.id != current_agent.id
  end
end
