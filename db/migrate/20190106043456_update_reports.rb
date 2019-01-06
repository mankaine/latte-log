class UpdateReports < ActiveRecord::Migration[5.2]
  def change
    remove_column :reports, :image_url
    add_column :reports, :picture, :string
  end
end
