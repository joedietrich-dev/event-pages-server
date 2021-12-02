class CreatePanelSponsorsTable < ActiveRecord::Migration[6.1]
  def change
    create_table :panel_sponsors do |t|
      t.references :panel, foreign_key: true
      t.references :sponsor, foreign_key: true
      t.timestamps
    end
  end
end
