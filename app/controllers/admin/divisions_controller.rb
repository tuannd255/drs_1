class Admin::DivisionsController < ApplicationController
  before_action :logged_in_user
  before_action :verify_admin
  before_action :find_division, except: [:create, :new, :index]

  def new
    @division = Division.new 
  end

  def create
    @division = Division.new division_params
    if @division.save
      flash[:success] = t "division.create.created"
      redirect_to admin_divisions_path
    else
      render :new
    end
  end

  def show
    @user = User.manager
  end

  def update
    if @division.update_attributes division_params
      flash[:success] = t "division.updated"
      redirect_to admin_divisions_path
    else
      render :edit
    end
  end

  def edit
  end

  def destroy
    if @division.destroy
      flash[:success] = t "division.deleted"
    else
      flash[:danger] = t "division.delete_fail"
    end
    redirect_to admin_divisions_path
  end

  def index
    @divisions = Division.paginate page: params[:page]
  end

  private
  def division_params
    params.require(:division).permit :descrition
  end

  def find_division
    @division = Division.find_by_id params[:id]
    redirect_to admin_divisions_path if @division.nil?
  end
end
