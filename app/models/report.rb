class Report < ActiveRecord::Base
  belongs_to :user

  validates :user_id, presence: true
  validates :report_date, presence: true
  validates :progress, presence: true, length: {maximum: 140}
  validates :achievement, presence: true, length: {maximum: 140}
  validates :next_day_plan, presence: true, length: {maximum: 140}
  validates :comment_question, length: {maximum: 140}
  validate :checkDateReport

  scope :oder_by_time, -> {order created_at: :desc}

  private
  def checkDateReport
    if self.report_date.present?    
      if self.report_date > Time.now
        errors.add :The, I18n.t("error.reportdate")
      end
    end
  end
end
