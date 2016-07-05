class RequestsController < ApplicationController
  before_action :logged_in_user, only: :create
  before_action :find_request, only: [:show, :edit, :update]
  before_action :set_kind_of_leave, only: :create

  def index
    if current_user.check_manager?
      @request = Request.new
      @requests = Request.all.paginate page: params[:page]
    else
      flash[:danger] = t "manager.fail"
      redirect_to root_path
    end
  end

  def create
    @request = current_user.requests.build request_params
    if @request.save
      @request.create_notification
      flash[:success] = t "request.created"
      redirect_to root_url
    else
      @feed_items = current_user.feed.order_by_time.paginate page: params[:page]
      render "static_pages/home"
    end
  end

  def edit
  end

  def update
    if @request.update_attributes approve: true
      flash[:success] = t "successapprove"
      redirect_to notifications_path
    else
      render :edit
    end
  end

  private
  def request_params
    params.require(:request).permit :kind_of_leave, :time_out, :time_in,
      :time, :compensation_time, :reason, :approve
  end

  def set_kind_of_leave
    @kind_of_leaves = Request.kind_of_leaves
  end

  def find_request
    @request = Request.find_by id: params[:id]
    redirect_to root_path if @request.nil?
  end 
end
