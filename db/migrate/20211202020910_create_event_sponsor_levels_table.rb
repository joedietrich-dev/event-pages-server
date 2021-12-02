class CreateEventSponsorLevelsTable < ActiveRecord::Migration[6.1]
  def change
    create_table :event_sponsor_levels do |t|
      t.string :name, null: false
      t.integer :rank, null: false, default: 0
      t.timestamps
    end
  end
end
