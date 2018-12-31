class UpdateReport < ActiveRecord::Migration[5.2]
  def change
    remove_column :reports, :url_image
    add_column :reports, :image_url, :string
  end
end
