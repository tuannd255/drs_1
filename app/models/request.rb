class Request < ActiveRecord::Base
  belongs_to :user
  has_many :notifications
  scope :order_by_time, -> {order created_at: :desc}
  scope :self_or_following, -> (user_id, following_ids) {where(
    "user_id = ? OR user_id IN (?)", user_id, following_ids)}
  
  validates :user_id, presence: true
  validates :reason, presence: true, length: {maximum: 140}
  validates :compensation_time, presence: true
  validate :check_kind_of_leave

  enum kind_of_leave: {il: 0, lo: 1, le: 2}

  scope :not_seen, -> {where "id in (
    select request_id from notifications where seen = 'f' )"}
  scope :accepted, -> {where "id in (
    select request_id from notifications where response = 't' )"}
  scope :checking, -> {where "id in (
    select request_id from notifications where response = 'f' )"}
  scope :checked, -> {where approve: true}
  scope :uncheck, -> {where approve: false}
  scope :check_user, -> (id) {where user_id: id}
  scope :search_request_by_date, -> (search) {where(
    "time_in LIKE :query OR time_out LIKE :query", query: "%#{search}%")}

  private
  def check_kind_of_leave
    if il?
      if self.time_in.nil?
        errors.add :The, I18n.t("error.innil")
      else
        self.time_out = :nil
      end
    elsif le?
      if self.time_out.nil?
        errors.add :The, I18n.t("error.outnil")
      else
        self.time_in = :nil
      end
    elsif
      if self.time_out.present? && self.time_in.present?
        if self.time_out > self.time_in
          errors.add :The, I18n.t("error.outin")
        else
          self.time = (self.time_in - self.time_out) / 60
        end
      elsif self.time_in.nil? && self.time_out.nil?
        errors.add :The, I18n.t("error.outin_nil")
      end
    end
  end
end
