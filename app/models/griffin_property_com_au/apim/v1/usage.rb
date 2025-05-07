# frozen_string_literal: true

module GriffinPropertyComAu
  module Apim
    module V1
      class Usage
        extend ActiveModel::Translation

        attr_accessor :usage

        def initialize(usage)
          @usage = usage
        end

        def localized_usage
          I18n.t("activerecord.attributes.property.usages.#{@usage}")
        end
      end
    end
  end
end
