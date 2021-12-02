class CreatePanelsTable < ActiveRecord::Migration[6.1]
  def change
    create_table :panels do |t|
      t.string :title, null: false
      t.string :description
      t.datetime :time
      t.references :event, foreign_key: true
      t.timestamps
    end
  end
end
