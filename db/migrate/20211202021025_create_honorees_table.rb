class CreateHonoreesTable < ActiveRecord::Migration[6.1]
  def change
    create_table :honorees do |t|
      t.string :honor
      t.string :name
      t.string :descriptor
      t.string :bio
      t.string :img_src
      t.references :event, foreign_key: true
      t.timestamps
    end
  end
end
