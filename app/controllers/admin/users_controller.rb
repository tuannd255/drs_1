class Admin::UsersController < ApplicationController
  before_action :logged_in_user
  before_action :verify_admin
  before_action :find_user, only: [:edit, :update, :destroy]

  def index
    @users = if params[:search]
      User.search_by_name_or_email params[:search]
    else
      User.paginate page: params[:page], per_page: Settings.perpage
    end
  end

  def destroy
    if @user.destroy
      flash[:success] = t "users.deleted"
      redirect_to admin_users_path
    else
      flash[:danger] = t "users.delete_fail"
      redirect_to root_path
    end
  end

  def edit
    set_profile
  end

  def update
    if @user.update_attributes user_params
      flash[:success] = t "successupdate"
      redirect_to admin_users_path
    else
      set_profile
      flash[:danger] = t "updatefail"
      render :edit
    end
  end

  private
  def user_params
    params.require(:user).permit profile_attributes: [:position_id,
      :id, :division_id]
  end

  def find_user
    @user = User.find_by_id params[:id]
    redirect_to root_path if @user.nil?
  end

  def set_profile
    @positions = Position.all.collect{|position| [position.position,
      position.id]}
  end
end
