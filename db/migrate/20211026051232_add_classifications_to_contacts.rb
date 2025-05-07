class AddClassificationsToContacts < ActiveRecord::Migration[6.1]
  def change
    add_reference :contacts, :classifiable, polymorphic: true, null: true, index: true
  end
end
