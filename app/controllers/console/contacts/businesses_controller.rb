# frozen_string_literal: true

module Console
  module Contacts
    class BusinessesController < Console::ContactsController
      private

      def create_contact_params
        params.require(:business).permit(:type, :agent_id, :account_id, :share, :first_name, :last_name, :individual_name, :legal_name, :job_title, :email, :phone, :mobile, :fax, :url, :registration, :notes, classifications: [], first_address: {}, second_address: {})
      end

      def update_contact_params
        params.require(:business).permit(:type, :agent_id, :account_id, :share, :first_name, :last_name, :individual_name, :legal_name, :job_title, :email, :phone, :mobile, :fax, :url, :registration, :notes, classifications: [], first_address: {}, second_address: {})
      end
    end
  end
end
