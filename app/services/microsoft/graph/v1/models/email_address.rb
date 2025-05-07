module Microsoft
  module Graph
    module V1
      module Models
        # Model for Microsoft's Graph EmailAddress
        # https://learn.microsoft.com/en-us/graph/api/resources/emailaddress?view=graph-rest-1.0
        class EmailAddress
          attr_accessor :name, :address

          def initialize(params = {})
            @name    = params[:name]
            @address = params[:address]
          end

          def to_h
            hash = {}
            hash.merge!({ address: @address }) if @address.present?
            hash.merge!({ name: @name }) if @name.present?
            hash
          end
        end
      end
    end
  end
end
