class Admin::PositionsController < ApplicationController
  before_action :logged_in_user
  before_action :verify_admin
  before_action :find_position, except: [:create, :new, :index]

  def new
    @position = Position.new 
  end

  def create
    @position = Position.new position_params
    if @position.save
      flash[:success] = t "position.create.created"
      redirect_to admin_positions_path
    else
      render :new
    end
  end

  def update
    if @position.nil?
      flash[:danger] = t "position.nil"
      redirect_to admin_positions_path
    else
      if @position.update_attributes position_params
        flash[:success] = t "position.updated"
        redirect_to admin_positions_path
      else
        render :edit
      end
    end
  end

  def destroy
    if @position.nil?
      flash[:danger] = t "position.nil"
    else
      if @position.destroy
        flash[:success] = t "position.deleted"
      else
        flash[:danger] = t "position.delete_fail"
      end
    end
    redirect_to admin_positions_path    
  end

  def index
    @positions = Position.paginate page: params[:page]
  end

  private
  def position_params
    params.require(:position).permit :position
  end

  def find_position
    @position = Position.find_by_id params[:id]
    redirect_to admin_positions_path if @position.nil?
  end
end
