class CreateEventSponsorsTable < ActiveRecord::Migration[6.1]
  def change
    create_table :event_sponsors do |t|
      t.references :event_sponsor_level, foreign_key: true
      t.integer :order, null: false, default: 0
      t.references :event, foreign_key: true
      t.references :sponsor, foreign_key: true
      t.timestamps
    end
  end
end
