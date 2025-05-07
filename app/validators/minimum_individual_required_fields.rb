class MinimumIndividualRequiredFields < ActiveModel::Validator
  def initialize(object)
    @object = object
  end

  def validate
    if minimum_required_fields_missing?
      @object.errors.add :individual, "You need to enter in at least one of the following fields: #{minimum_required_fields.join(', ')}"
    end
  end

  private

  def minimum_required_fields_missing?
    @object.first_name.blank? &&
    @object.last_name.blank? &&
    @object.email.blank? &&
    @object.phone.blank? &&
    @object.mobile.blank?
  end

  def minimum_required_fields
    ['First name', 'Last name', 'Email', 'Phone', 'Mobile']
  end
end