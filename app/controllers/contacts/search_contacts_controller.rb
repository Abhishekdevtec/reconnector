module Contacts
  class SearchContactsController < ContactsController
    # GET /individuals or /individuals.json
    def index
      @pagy, @contacts = pagy(search_contacts.order(:last_name))
    end

    private

    def search_contacts
      @current_agent.contacts.visible_by(@current_agent).search(search_param)
    end

    def search_param
      params[:search]
    end
  end
end
