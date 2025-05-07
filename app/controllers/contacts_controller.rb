class ContactsController < ApplicationController
  include Pagy::Backend

  before_action :authenticate_agent!
  before_action :set_contact, only: :show
  before_action :set_nav_menu
  before_action :set_tab, only: :show
  before_action :set_search_path, only: %i[index show]

  after_action :mark_contact_as_viewed, only: :show

  # GET /contacts or /contacts.json
  def index
    items = if params[:filter]
              # Search for a contact which starts with a number
              if params[:filter] == '#'
                Contact
                  .visible_by(@current_agent)
                  .where("last_name ~ '^[0-9]'")
                  .or(
                    Contact
                      .visible_by(@current_agent)
                      .where("business_name ~ '^[0-9]'")
                  )
              else
                Contact
                  .visible_by(@current_agent)
                  .where('last_name ILIKE ?', params[:filter] + '%')
                  .or(
                    Contact
                      .visible_by(@current_agent)
                      .where('business_name ILIKE ?', params[:filter] + '%')
                  )
              end
            else
              Contact.visible_by(@current_agent)
            end
    # @contacts = items.sort_by(&:initial).group_by(&:initial)
    @pagy, @contacts = pagy(items)
  end

  def show; end

  # DELETE /individuals/1 or /individuals/1.json or
  # DELETE /businesses/1 or /businesses/1.json
  def destroy
    # TODO: Move this to a service
    @current_agent.contacts.find(params[:id]).destroy
    respond_to do |format|
      format.html { redirect_to contacts_url, notice: 'Contact was successfully deleted.', status: :see_other }
      format.json { head :no_content }
    end
  end

  private

  def mark_contact_as_viewed
    if @business
      @business.remark_as_viewed(viewer: Current.agent, delete_old: true)
    elsif @individual
      @individual.remark_as_viewed(viewer: Current.agent, delete_old: true)
    end
  end

  def build_new_contact_addresses(contact)
    contact.build_physical_address
    contact.build_postal_address

    # Set the default country & state values based on the current agent
    contact.physical_address.country = Current.country.presence
    contact.physical_address.state   = Current.state.presence
    contact.postal_address.country = Current.country.presence
    contact.postal_address.state   = Current.state.presence
  end

  # Override in child classes IF needed
  def set_nav_menu
    set_nav_menu_option(:contacts)
  end

  def set_tab
    set_tab_option(:details)
  end

  def set_search_path
    @search_path = search_contacts_path
    @search_placeholder = 'Search contacts by name, business, email, phone, mobile or fax'
  end

  def set_contact
    raise 'Not implemented, needs to be implemented in child classes'
  end
end
