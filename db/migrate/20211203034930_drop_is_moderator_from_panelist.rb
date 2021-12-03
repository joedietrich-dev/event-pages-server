class DropIsModeratorFromPanelist < ActiveRecord::Migration[6.1]
  def change
    remove_column :panelists, :is_moderator, :string, null: false, default: false
    add_column :panel_panelists, :is_moderator, :boolean, null: false, default: false
  end
end
