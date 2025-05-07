# frozen_string_literal: true

module Properties
  class SharesController < ApplicationController
    before_action :authenticate_agent!
    before_action :set_property

    def create
      @property.update(share: true) if PropertiesPolicy.update?(@property, Current.agent)
      redirect_to @property, status: :see_other
    end

    def destroy
      @property.update(share: false) if PropertiesPolicy.update?(@property, Current.agent)
      redirect_to @property, status: :see_other
    end

    private

    def set_property
      @property = Current.agent.properties.find(params[:id])
    end
  end
end
