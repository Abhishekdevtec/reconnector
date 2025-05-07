# frozen_string_literal: true

module HasMoneytaryAttributes
  extend ActiveSupport::Concern

  class_methods do
    # Defines the instance methods name/name= from AssignableName.
    def monetary_attribute(attr)
      create_element_accessors(attr)
    end

    # Create child element accessors.
    def create_element_accessors(name)
      define_method(name) do
        return nil if attributes["#{name}_cents"].nil?

        attributes["#{name}_cents"] / 100.0
      end

      define_method("#{name}=") do |val|
        if val.nil?
          write_attribute("#{name}_cents", nil)
          return
        end
        write_attribute("#{name}_cents", (val.to_f * 100).to_i)
      end
    end
  end
end
