class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :notify
  include SessionsHelper

  private
  def notify
    if logged_in?
      @notifications_count = if current_user.check_manager? or
        current_user.admin?
        Request.uncheck.not_seen.size
      else
        Request.checked.accepted.not_seen.check_user(current_user.id).size
      end
    end
  end

  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = t "login.please"
      redirect_to login_url
    end
  end

  def correct_user
    @user = User.find_by id: params[:id]
    unless @user.current_user? current_user
      flash[:danger] = t "users.not_be_user"
      redirect_to root_url 
    end
  end
  
  def verify_admin
    redirect_to root_path unless current_user.admin?
  end

  def correct_manager_and_user
    @user = User.find_by id: params[:id]
    unless current_user.check_manager? || @user.current_user?(current_user)
      flash[:danger] = t "manager.fail"
      redirect_to root_path
    end
  end
end
