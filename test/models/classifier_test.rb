# == Schema Information
#
# Table name: classifiers
#
#  account_id :bigint           not null
#  created_at :datetime         not null
#  id         :bigint           not null, primary key
#  name       :string
#  updated_at :datetime         not null
#
# Indexes
#
#  index_classifiers_on_account_id  (account_id)
#
require "test_helper"

class ClassifierTest < ActiveSupport::TestCase
  context 'validations' do
    should belong_to :account

    should validate_presence_of(:name)
    should validate_length_of(:name).is_at_least(2)
  end
end
