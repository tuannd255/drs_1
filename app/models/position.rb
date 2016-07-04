class Position < ActiveRecord::Base
  has_many :profiles

  validates :position, presence: true, length: {maximum: 50}
end
