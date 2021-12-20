class Event < ActiveRecord::Base
  has_many :panels, dependent: :destroy
  has_many :panel_panelists, through: :panels
  has_many :hosts, dependent: :destroy
  has_many :honorees, dependent: :destroy
  has_many :event_sponsors, dependent: :destroy
  has_many :sponsors, through: :event_sponsors
  has_many :event_sponsor_levels, through: :event_sponsors

  validates :title, presence: true
end