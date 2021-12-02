class PanelPanelist < ActiveRecord::Base
  belongs_to :panel
  belongs_to :panelist
end