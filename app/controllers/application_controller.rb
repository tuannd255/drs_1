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
    redirect_to root_url unless @user.current_user? current_user
  end
  
  def verify_admin
    redirect_to root_path unless current_user.admin?
  end
end
