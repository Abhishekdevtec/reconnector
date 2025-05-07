class ContractMustBeForLeaseOrForSale < ActiveModel::Validator
  def initialize(object)
    @object = object
  end

  def validate
    @object.errors.add :contract, 'A contract must be for lease or for sale' unless for_lease_or_for_sale?
  end

  private

  def for_lease_or_for_sale?
    @object.for_lease || @object.for_sale
  end
end
