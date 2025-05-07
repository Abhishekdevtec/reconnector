module ContractsHelper
  def contract_total_annual_rent_label(contract)
    return 'None' if contract.nil? || contract.not_for_lease?

    number_to_currency(contract.lease_total_gross_rent, precision: 0, locale: :'en-AU')
  end

  def contract_sales_price_label(contract)
    return 'None' if contract.nil? || contract.not_for_sale?

    number_to_currency(contract.sale_actual_sale_price, precision: 0, locale: :'en-AU')
  end
end
