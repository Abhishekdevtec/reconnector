class AddWebsiteUrlToProperties < ActiveRecord::Migration[7.0]
  def change
    add_column :properties, :website_url, :string, default: nil
  end
end
