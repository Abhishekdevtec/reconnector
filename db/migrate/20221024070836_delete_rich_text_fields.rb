class DeleteRichTextFields < ActiveRecord::Migration[7.0]
  def change
    rename_column :properties, :brochure_description, :brochure_description_deprecated
    rename_column :properties, :fit_out, :fit_out_deprecated
    rename_column :properties, :furniture, :furniture_deprecated
    rename_column :properties, :notes, :notes_deprecated
    rename_column :properties, :website_description, :website_description_deprecated
  end
end
