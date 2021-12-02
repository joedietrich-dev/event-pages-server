class CreateHostsTable < ActiveRecord::Migration[6.1]
  def change
    create_table :hosts do |t|
      t.string :name, null: false
      t.string :bio
      t.string :headshot_src
      t.references :event, foreign_key: true
      t.timestamps
    end
  end
end
