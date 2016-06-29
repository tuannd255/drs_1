class RequestsController < ApplicationController
  before_action :logged_in_user, only: :create
  before_action :set_kind_of_leave, only: :create

  def create
    @request = current_user.requests.build request_params
    if @request.save
      flash[:success] = t "request.created"
      redirect_to root_url
    else
      @feed_items = current_user.feed.order_by_time.paginate page: params[:page]
      render "static_pages/home"
    end
  end

  private
  def request_params
    params.require(:request).permit :kind_of_leave, :time_out, :time_in,
      :time, :compensation_time, :reason
  end

  def set_kind_of_leave
    @kind_of_leaves = Request.kind_of_leaves
  end
end
