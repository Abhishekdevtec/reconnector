class AccountsAreCoherentValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    record.errors.add attribute, (options[:message] || "is not equal to the Agent Account") unless accounts_are_coherent?(record, value)
  end

  private

  def accounts_are_coherent?(record, account_id)
    account_id == record.try(:agent).try(:account_id)
  end
end
