class Notification < ActiveRecord::Base
  belongs_to :user
  belongs_to :request

  scope :unread, -> {where seen: false}
end
