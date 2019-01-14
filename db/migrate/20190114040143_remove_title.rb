class RemoveTitle < ActiveRecord::Migration[5.2]
  def change
    remove_column :videos, :title
  end
end
