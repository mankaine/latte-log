class CreateReports < ActiveRecord::Migration[5.2]
  def change
    create_table :reports do |t|
      t.text :notes
      t.datetime :coffee_made_at
      t.datetime :created_at, :null => false
      t.datetime :updated_at, :null => false
      t.string :picture
      t.timestamps
    end
  end
end
