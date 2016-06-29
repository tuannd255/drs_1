class StaticPagesController < ApplicationController
  def home
    if logged_in?
      @request = current_user.requests.build
      @kind_of_leaves = Request.kind_of_leaves
      @feed_items = current_user.feed.order_by_time.paginate page: params[:page]
    end
  end

  def help
  end

  def about
  end
end
