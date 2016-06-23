class UsersController < ApplicationController

  def show
    if logged_in?
      @user = User.find params[:id]
    else
      redirect_to root_path
    end
  end

  def new
    @user = User.new
    @sex = User.genders
  end

  def create
    @sex = User.genders
    @user = User.new user_params
    if @user.save
      log_in @user
      flash[:success] = t "welcome", user_name: @user.name
      redirect_to @user
    else
      render :new
    end
  end

  private
  def user_params
    params.require(:user).permit :name, :email, :gender, :birthday,
      :password, :password_confirmation
  end
end
