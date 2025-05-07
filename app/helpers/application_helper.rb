module ApplicationHelper
  def menu_items
    default_classes = 'hover:text-gray-700 px-3 py-2 rounded-md text-sm font-medium text-gray-900'
    current_classes = 'bg-gray-200 px-3 py-2 rounded-md text-sm font-medium text-gray-900'
    content_tag(:div, class: 'flex space-x-4') do
      concat link_to('Dashboard', agent_root_path, class: @nav_menu_option == :dashboard ? current_classes : default_classes)
      concat link_to('Properties', properties_path, class: @nav_menu_option == :properties ? current_classes : default_classes)
      concat link_to('Enquiries', listing_enquiries_path, class: @nav_menu_option == :listing_enquiries ? current_classes : default_classes)
      concat link_to('Contacts', contacts_path, class: @nav_menu_option == :contacts ? current_classes : default_classes)
    end
  end

  def mobile_menu_items
    default_classes = 'hover:bg-gray-100 block px-3 py-2 rounded-md font-medium text-gray-900'
    current_classes = 'bg-gray-100 block px-3 py-2 rounded-md font-medium text-gray-900'
    content_tag(:div, class: 'px-2 pt-2 pb-3 space-y-1') do
      concat link_to('Dashboard', agent_root_path, class: @nav_menu_option == :dashboard ? current_classes : default_classes)
      concat link_to('Properties', properties_path, class: @nav_menu_option == :properties ? current_classes : default_classes)
      concat link_to('Enquiries', listing_enquiries_path, class: @nav_menu_option == :enquiries ? current_classes : default_classes)
      concat link_to('Contacts', contacts_path, class: @nav_menu_option == :contacts ? current_classes : default_classes)
    end
  end
end
