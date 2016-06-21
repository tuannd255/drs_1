class Profile < ActiveRecord::Base
  belongs_to :user
  belongs_to :division
  belongs_to :skill
  belongs_to :position
end
