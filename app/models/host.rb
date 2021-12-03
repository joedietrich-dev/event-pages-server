class Host < ActiveRecord::Base
  belongs_to :event

  validates :name, presence: true
end
