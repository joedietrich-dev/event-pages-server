class CreateSponsorsTable < ActiveRecord::Migration[6.1]
  def change
    create_table :sponsors do |t|
      t.string :name, null: false
      t.string :logo_src
      t.timestamps
    end
  end
end
