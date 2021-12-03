class Event < ActiveRecord::Base
  has_many :panels
  has_many :panel_panelists, through: :panels
  has_many :hosts
  has_many :honorees
  has_many :event_sponsors
  has_many :sponsors, through: :event_sponsors
  has_many :event_sponsor_levels, through: :event_sponsors

  validates :title, presence: true

  def panelists
    []
  end
end