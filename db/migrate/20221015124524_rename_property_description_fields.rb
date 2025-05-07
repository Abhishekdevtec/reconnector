class RenamePropertyDescriptionFields < ActiveRecord::Migration[7.0]
  def change
    rename_column :properties, :features, :website_description
    rename_column :properties, :description, :brochure_description

    # Rename the ActionText::RichText entries too
    ActionText::RichText.transaction do
      ActionText::RichText.where(name: 'features').update_all(name: 'website_description')
      ActionText::RichText.where(name: 'description').update_all(name: 'brochure_description')
    end
  end
end
