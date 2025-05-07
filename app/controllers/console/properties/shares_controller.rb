# frozen_string_literal: true

class Console::Properties::SharesController < ConsoleController
  before_action :set_property

  def create
    @property.update(share: true)
    redirect_to @property, status: :see_other
  end

  def destroy
    @property.update(share: false)
    redirect_to @property, status: :see_other
  end

  private

  def set_property
    @property = @account.properties.find(params[:property_id])
  end
end
