# frozen_string_literal: true

module Accounts
  class MicrosoftGraphSettingsController < ApplicationController
    before_action :authenticate_agent!
    before_action :verify_account_manager!
    before_action :set_selected_account_menu_option

    private

    def set_selected_account_menu_option
      @selected_account_menu_option = :microsoft_graph_settings
    end
  end
end
