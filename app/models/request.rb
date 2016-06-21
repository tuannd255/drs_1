class Request < ActiveRecord::Base
  has_many :user_requests, dependent: :destroy
end
