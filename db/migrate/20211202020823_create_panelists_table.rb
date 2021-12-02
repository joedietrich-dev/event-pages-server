class CreatePanelistsTable < ActiveRecord::Migration[6.1]
  def change
    create_table :panelists do |t|
      t.string :name, null: false
      t.string :title
      t.string :company
      t.string :bio
      t.string :headshot_src
      t.string :is_moderator, null: false, default: false
      t.timestamps
    end
  end
end
