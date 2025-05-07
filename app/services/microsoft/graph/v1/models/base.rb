module Microsoft
  module Graph
    module V1
      module Models
        class Base
          # Must be overriden by the child class
          # def attributes
          #   raise NotImplemented
          # end

          def attributes_to_json
            camelized_attributes = {}
            attributes.each do |key, value|
              camelized_key = key.split('_').map.with_index { |word, index| index == 0 ? word : word.capitalize }.join
              camelized_attributes[camelized_key] = value
            end
            camelized_attributes.to_json
          end
        end
      end
    end
  end
end
