# frozen_string_literal: true

module AppServices
  module Email
    # Generic email sending class which sends an email
    class GenericProvider
      def initialize(params)
        @params = params
      end

      def send_message
        raise NotImplemented
      end
    end
  end
end
