class CreateVideos < ActiveRecord::Migration[5.2]
  def change
    create_table :videos do |t|
      t.text :notes
      t.string :url
      t.datetime :created_at, :null => false
      t.datetime :updated_at, :null => false
      t.timestamps
    end
  end
end
