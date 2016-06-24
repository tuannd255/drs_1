class User < ActiveRecord::Base
  attr_accessor :remember_token

  before_save {self.email = email.downcase}

  has_many :user_requests, dependent: :destroy
  has_many :notifications, dependent: :destroy
  has_many :active_relationships, class_name: Relationship.name,
    foreign_key: "follower_id", dependent: :destroy
  has_many :passive_relationships, class_name: Relationship.name,
    foreign_key: "followed_id", dependent: :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower
  has_one :profile

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i 

  validates :password, presence: true, length: {minimum: 6}, allow_nil: true
  validates :name,  presence: true, length: {maximum: 50}
  validates :email, presence: true, length: {maximum: 255},
    format: {with: VALID_EMAIL_REGEX},
    uniqueness: {case_sensitive: false}
  
  enum gender: ["male", "female", "less", "gay"]

  after_create :create_profile
  accepts_nested_attributes_for :profile

  has_secure_password

  def create_profile
    Profile.create(user_id: id)
  end

  class << self
    def digest string
      cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
        BCrypt::Engine.cost
      BCrypt::Password.create(string, cost: cost)
    end
  
    def new_token
      SecureRandom.urlsafe_base64
    end
  end  

  def remember
    self.remember_token = User.new_token
    update_attributes remember_digest: User.digest(remember_token)
  end

  def authenticated? remember_token
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end
  
  def current_user? current_user
    self == current_user
  end

  def forget
    update_attributes remember_digest: :nil
  end
end
