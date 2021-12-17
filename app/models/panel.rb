class Panel < ActiveRecord::Base
  belongs_to :event
  has_many :panel_panelists, dependent: :destroy
  has_many :panelists, through: :panel_panelists
  has_many :panel_sponsors, dependent: :destroy
  has_many :sponsors, through: :panel_sponsors
  
  validates :title, presence: true

#  scope :moderated_by, -> { joins(:panel_panelists).where(panel_panelists: {is_moderator: true})}

  def moderators
    self.panelists.joins(:panel_panelists).where('is_moderator = ?', true)
  end
end