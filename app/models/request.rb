class Request < ActiveRecord::Base
  belongs_to :user

  scope :oder_by_time, -> {order created_at: :desc}
  
  validates :user_id, presence: true
  validates :reason, presence: true, length: {maximum: 140}
  validates :compensation_time, presence: true
  validate :check_kind_of_leave

  enum kind_of_leave: {il: 0, lo: 1, le: 2}

  private
  def check_kind_of_leave
    if il?
      if time_in.nil?
        errors.add :The, I18n.t("error.innil")
      else
        time_out = :nil
      end
    elsif le?
      if time_out.nil?
        errors.add :The, I18n.t("error.outnil")
      else
        time_in = :nil
      end
    elsif
      if time_out.present? && time_in.present?
        if time_out > time_in
          errors.add :The, I18n.t("error.outin")
        else
          time = (time_in - time_out) / 60
        end
      elsif time_in.nil? && time_out.nil?
        errors.add :The, I18n.t("error.outin_nil")
      end
    end
  end
end
