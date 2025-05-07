# frozen_string_literal: true

class AccessRequestsController < ApplicationController
  layout 'pages'

  def new
    @access_request = AccessRequest.new
  end

  def create
    @access_request = AccessRequest.new(access_request_params)

    if @access_request.save
      render :show, status: :created
    else
      render :new, status: :unprocessable_entity unless @access_request.save
    end
  end

  private

  def access_request_params
    params
      .require(:access_request)
      .permit(
        :agent_count,
        :company,
        :email,
        :first_name,
        :last_name,
        :phone,
        :request
      )
  end
end
