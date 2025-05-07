# frozen_string_literal: true

module SortableAttributes
  extend ActiveSupport::Concern

  def sort_params?
    params[:sort_attribute].present? && params[:sort_order].present?
  end

  def sort_ressource_params
    return {} unless sort_params?

    {
      sort_attribute: params[:sort_attribute],
      sort_order: params[:sort_order]
    }
  end
end
