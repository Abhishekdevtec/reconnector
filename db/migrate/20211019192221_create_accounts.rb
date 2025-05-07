class CreateAccounts < ActiveRecord::Migration[6.1]
  def change
    create_table :accounts do |t|
      t.string :company_name
      t.string :legal_name
      t.string :domain_name

      t.timestamps
    end
  end
end
