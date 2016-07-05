class NotificationsController < ApplicationController
  after_action :set_seen_true, only: :index
  def index
    if Notification.unread.blank?
      @requests = Request.order_by_time.paginate page: params[:page]
    else
      @requests = Request.not_seen.paginate page: params[:page]
    end
  end

  private
  def set_seen_true
    Notification.unread.each do |notification|
      notification.update_attributes seen: true
    end
  end
end
