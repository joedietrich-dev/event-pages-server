class PanelSponsor < ActiveRecord::Base
  belongs_to :panel
  belongs_to :sponsor
end