class EventSponsor < ActiveRecord::Base
  belongs_to :event
  belongs_to :sponsor
  belongs_to :event_sponsor_level
end