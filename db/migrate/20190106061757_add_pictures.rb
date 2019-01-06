class AddPictures < ActiveRecord::Migration[5.2]
  def change
    rename_column :reports, :image_url, :picture
  end
end
