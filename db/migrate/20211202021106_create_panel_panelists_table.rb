class CreatePanelPanelistsTable < ActiveRecord::Migration[6.1]
  def change
    create_table :panel_panelists do |t|
      t.references :panel, foreign_key: true
      t.references :panelist, foreign_key: true
      t.timestamps
    end
  end
end
