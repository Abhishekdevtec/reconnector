class CreateContacts < ActiveRecord::Migration[6.1]
  def change
    create_table :contacts do |t|
      t.string :type
      t.belongs_to :agent, null: false, index: true, foreign_key: true
      t.belongs_to :account, null: false, index: true, foreign_key: true
      t.boolean :share, default: false
      t.string :first_name
      t.string :last_name
      t.string :business_name
      t.string :legal_name
      t.string :job_title
      t.string :email
      t.string :phone
      t.string :mobile
      t.string :fax
      t.string :url
      t.string :registration
      t.string :skype
      t.string :source_id
      t.text   :notes

      t.timestamps
    end
  end
end
