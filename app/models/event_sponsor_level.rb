class EventSponsorLevel < ActiveRecord::Base
  has_many :event_sponsors

  validates :name, presence: true
end
