class Division < ActiveRecord::Base
  has_many :profiles

  validates :descrition, presence: true, length: {maximum: 50}
end
