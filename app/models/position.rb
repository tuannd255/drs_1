class Position < ActiveRecord::Base
  has_many :profiles, dependent: :destroy

  validates :position, presence: true, length: {maximum: 50}
end
