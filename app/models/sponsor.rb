class Sponsor < ActiveRecord::Base
  has_many :event_sponsors
  has_many :event_sponsor_levels, through: :event_sponsors
  has_many :events, through: :event_sponsors
  has_many :panel_sponsors
  has_many :panels, through: :panel_sponsors
end
