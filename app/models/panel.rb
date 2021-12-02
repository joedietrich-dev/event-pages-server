class Panel < ActiveRecord::Base
  belongs_to :event
  has_many :panel_panelists
  has_many :panelists, through: :panel_panelists
  has_many :panel_sponsors
  has_many :sponsors, through: :panel_sponsors
end