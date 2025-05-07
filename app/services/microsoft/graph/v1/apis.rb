# frozen_string_literal: true

module Microsoft
  module Graph
    module V1
      module Apis
        include Apis::Me
        include Apis::Mail
        include Apis::Contacts
      end
    end
  end
end
