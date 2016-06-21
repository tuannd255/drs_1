class Position < ActiveRecord::Base
  has_many :profiles, dependent: :destroy
end
