class Sponsor < ActiveRecord::Base
  has_many :event_sponsors, dependent: :destroy
  has_many :event_sponsor_levels, through: :event_sponsors
  has_many :events, through: :event_sponsors
  has_many :panel_sponsors, dependent: :destroy
  has_many :panels, through: :panel_sponsors
  
  validates :name, presence: true
end
