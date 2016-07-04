class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper

  private
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
    unless current_user.profile.position == Position.first || 
      @user.current_user?(current_user)
      flash[:danger] = t "manager.fail"
      redirect_to root_path
    end
  end
end
