class CreateMicrosoftGraphObjectData < ActiveRecord::Migration[7.0]
  def change
    create_table :ms_graph_object_data do |t|
      t.string     :object_id
      t.string     :change_key
      t.string     :parent_folder_id
      t.string     :etag
      t.datetime   :created_date_time
      t.datetime   :last_modified_date_time
      t.datetime   :last_sent_at
      t.datetime   :last_received_at
      t.references :microsoft_graph_synchronizable, polymorphic: true, null: false

      t.timestamps
    end
  end
end
