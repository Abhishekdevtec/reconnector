module PropertiesHelper
  include Pagy::Frontend

  def property_index_tabs
    @page_tabs = []
    @page_tabs << PageTabComponent.new(name: 'All', url: properties_path, active: controller_name.eql?('properties'))
    @page_tabs << PageTabComponent.new(name: 'Commercial', url: commercial_properties_path, active: controller_name.include?('commercial'))
    @page_tabs << PageTabComponent.new(name: 'Industrial', url: industrial_properties_path, active: controller_name.include?('industrial'))
    @page_tabs << PageTabComponent.new(name: 'Residential', url: residential_properties_path, active: controller_name.include?('residential'))
    @page_tabs << PageTabComponent.new(name: 'Retail', url: retail_properties_path, active: controller_name.include?('retail'))
    @page_tabs << PageTabComponent.new(name: 'Archived', url: archived_properties_path, active: controller_name.include?('archived'))
  end

  def new_commercial_property_button
    content_tag(:span, class: 'block') do
      link_to(new_commercial_property_path, class: 'inline-flex items-center px-4 py-2 border border-gray-300 rounded-md shadow-sm text-sm font-medium text-gray-700 bg-white hover:bg-gray-50 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-offset-gray-50 focus:ring-purple-500', role: 'button') do
        concat '<svg xmlns="http://www.w3.org/2000/svg" class="-ml-1 mr-2 h-5 w-5 text-gray-400" fill="none" viewBox="0 0 24 24" stroke="currentColor"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 4v16m8-8H4" /></svg>'.html_safe
        concat 'New'
      end
    end
  end

  def edit_property_button(property)
    content_tag(:span, class: 'block') do
      link_to [:edit, property], class: 'inline-flex items-center px-4 py-2 border border-gray-300 rounded-md shadow-sm text-sm font-medium text-gray-700 bg-white hover:bg-gray-50 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-offset-gray-50 focus:ring-purple-500', role: 'button' do
        concat '<svg class="-ml-1 mr-2 h-5 w-5 text-gray-400" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="currentColor" aria-hidden="true"><path d="M13.586 3.586a2 2 0 112.828 2.828l-.793.793-2.828-2.828.793-.793zM11.379 5.793L3 14.172V17h2.828l8.38-8.379-2.83-2.828z" /></svg>'.html_safe
        concat 'Edit'
      end
    end
  end

  def pagination_navigation(pagy = nil)
    return pagy_nav(pagy).html_safe if pagy.pages > 1
  end

  # true if the property.id is present
  # in the flash[:property_ids] array
  def property_selected?(id)
    return false if flash[:property_ids].nil?

    flash[:property_ids].include?(id.to_s)
  end

  def current_property_tab?(tab_sym)
    @current_property_tab == tab_sym
  end

  def edit_property_header(property)
    property.name ? "Edit #{property.name}" : "Edit #{property.type_label} property"
  end

  def property_type_collection
    [
      OpenStruct.new(name: 'Commercial property', type: 'CommercialProperty'),
      OpenStruct.new(name: 'Industrial property', type: 'IndustrialProperty'),
      OpenStruct.new(name: 'Residential property', type: 'ResidentialProperty'),
      OpenStruct.new(name: 'Retail property', type: 'RetailProperty')
    ]
  end

  def property_area_label(area)
    return 'None' if area.blank?

    "#{number_with_precision(area, precision: 2)} sq. m."
  end
end
