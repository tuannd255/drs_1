class StaticPagesController < ApplicationController
  def home
    if logged_in?
      @request = current_user.requests.build
      @kol = Request.kind_of_leaves
      @feed_items = current_user.feed.oder_by_time.paginate page: params[:page]
    else
      @feed_items  = Request.all.oder_by_time.paginate page: params[:page]
    end
  end

  def help
  end

  def about
  end
end
