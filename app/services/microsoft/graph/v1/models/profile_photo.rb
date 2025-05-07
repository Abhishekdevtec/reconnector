module Microsoft
  module Graph
    module V1
      module Models
        # Model for Microsoft's Graph ProfilePhoto
        # https://learn.microsoft.com/en-us/graph/api/resources/profilephoto?view=graph-rest-1.0
        class ProfilePhoto
          def initialize(params = {})
            @id     = params[:id]
            @height = params[:height]
            @width  = params[:width]
          end
        end
      end
    end
  end
end
