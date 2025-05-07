class MinimumBusinessRequiredFields < ActiveModel::Validator
  def initialize(object)
    @object = object
  end

  def validate
    if minimum_required_fields_missing?
      @object.errors.add :business, "You need to enter in at least one of the following fields: #{minimum_required_fields.join(', ')}"
    end
  end

  private

  def minimum_required_fields_missing?
    @object.business_name.blank? &&
    @object.legal_name.blank? &&
    @object.email.blank? &&
    @object.phone.blank?
  end

  def minimum_required_fields
    ['Business name', 'Legal name', 'Email', 'Phone']
  end
end