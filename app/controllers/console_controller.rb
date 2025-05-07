# frozen_string_literal: true

class ConsoleController < ApplicationController
  before_action :authenticate_overlord!
  before_action :set_account

  layout 'console'

  private

  def set_account
    @account = Account.find(params[:account_id]) if params[:account_id].present?
  end
end
