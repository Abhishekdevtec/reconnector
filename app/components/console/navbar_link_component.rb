# frozen_string_literal: true

module Console
  class NavbarLinkComponent < ViewComponent::Base
    private attr_reader :title, :url, :active, :options

    def initialize(title, url, active = false, options = {})
      @title   = title
      @url     = url
      @active  = active
      @options = if options[:class].blank?
                   options.merge(class_options)
                 else
                   @options = options
                 end
    end

    def class_options
      return active_classes if @active

      standard_classes
    end

    private

    def active_classes
      { class: 'bg-red-700 text-white px-3 py-2 rounded-md text-sm font-medium' }
    end

    def standard_classes
      { class: 'text-white hover:bg-red-500 hover:bg-opacity-75 px-3 py-2 rounded-md text-sm font-medium' }
    end
  end
end
