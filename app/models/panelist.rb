class Panelist < ActiveRecord::Base
  has_many :panel_panelists
  has_many :panels, through: :panel_panelists
  
  validates :name, presence: true

  def events
    []
  end
end
