# frozen_string_literal: true

class PropertyQuery
  attr_accessor :records

  def call(scope, params = {})
    @initial_scope = scope
    @params = params
    @sort_attribute = params.delete(:sort_attribute)
    @sort_order = params.delete(:sort_order)

    @records = @initial_scope
    sort if sort_params?
    @records
  end

  private

  def sort
    sort_string = [@sort_attribute, @sort_order.upcase, 'NULLS LAST'].join(' ')
    @records = @records.reorder(sort_string)
  end

  def sort_params?
    @sort_attribute.present? && @sort_order.present?
  end
end
