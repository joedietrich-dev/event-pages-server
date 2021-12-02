class Panelist < ActiveRecord::Base
  has_many :panel_panelists
  has_many :panels, through: :panel_panelists

  def events
    []
  end
end
