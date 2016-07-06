class UsersController < ApplicationController
  before_action :logged_in_user, except: [:new, :create]
  before_action :correct_manager_and_user, only: :update
  before_action :correct_user, only: :edit
  before_action :find_user, only: [:show, :edit, :update]
  before_action :set_gender, only: [:new, :create, :edit]

  def index
    @users = if params[:search]
      User.search_by_name_or_email params[:search]
    else
      User.paginate page: params[:page], per_page: Settings.perpage
    end
  end

  def show
    @requests = @user.requests.order_by_time.paginate page: params[:page],
      per_page: Settings.perpage
  end

  def new
    if logged_in?
      redirect_to root_path
    else
      @user = User.new
    end
  end

  def create
    @user = User.new user_params
    if @user.save
      @user.create_profile position: Position.second
      log_in @user
      flash[:success] = t "welcome", user_name: @user.name
      redirect_to @user
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @user.update_attributes user_params
      flash[:success] = t "successupdate"
      redirect_to @user
    else
      render :edit
    end
  end

  private
  def find_user
    @user = User.find_by id: params[:id]
    redirect_to root_path if @user.nil?
  end

  def user_params
    params.require(:user).permit :name, :email, :gender, :birthday,
      :password, :password_confirmation, profile_attributes: [:division_id,
      :skill_id, :position_id, :id]
  end

  def set_gender
    @sex = User.genders
  end
end
