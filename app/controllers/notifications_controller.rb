class NotificationsController < ApplicationController
  after_action :set_seen_true, only: :index
  
  def index
    if current_user.check_manager? or current_user.admin?
      @requests = if Request.uncheck.checking.blank?
        Request.order_by_time.paginate page: params[:page],
          per_page: Settings.perpage
      else
        Request.uncheck.checking.paginate page: params[:page],
          per_page: Settings.perpage
      end
    else
      @requests = Request.checked.not_seen.check_user(current_user.id)
        .paginate page: params[:page], per_page: Settings.perpage
    end
  end

  private
  def set_seen_true
    if @notifications_count >= 1
      if current_user.check_manager? or current_user.admin?
        Notification.unread.each do |notification|
          notification.update_attributes seen: true
        end
      else
        Request.checked.each do |request|
          request.notifications.unread.each do |notification|
            notification.update_attributes seen: true
          end
        end
      end
    end
  end
end
