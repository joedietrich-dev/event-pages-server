class CreateEventsTable < ActiveRecord::Migration[6.1]
  def change
    create_table :events do |t|
      t.string :title, null: false
      t.string :description
      t.string :short_description
      t.string :location
      t.string :hero_src
      t.string :register_link
      t.string :view_link
      t.datetime :date
      t.timestamps
    end
  end
end
