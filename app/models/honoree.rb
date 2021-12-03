class Honoree < ActiveRecord::Base
  belongs_to :event

  validates :honor, presence: true
  validates :name, presence: true
end