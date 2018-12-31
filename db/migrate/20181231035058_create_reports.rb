class CreateReports < ActiveRecord::Migration[5.2]
  def change
    create_table :reports do |t|
      t.text :notes
      t.string :url
      t.datetime :coffee_made_at

      t.timestamps
    end
  end
end
