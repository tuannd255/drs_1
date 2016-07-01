class Division < ActiveRecord::Base
  has_many :profiles, dependent: :destroy

  validates :descrition, presence: true, length: {maximum: 50}
end
