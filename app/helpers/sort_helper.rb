# frozen_string_literal: true

module SortHelper
  def reverse_current_sort_order
    %w(asc desc).include?(params[:sort_order]) ? reverse_sort_order(params[:sort_order]) : default_sort_order
  end

  private

  def reverse_sort_order(order)
    return 'asc' if order == 'desc'

    'desc'
  end

  def default_sort_order
    'desc'
  end
end
