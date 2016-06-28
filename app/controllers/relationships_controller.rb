class RelationshipsController < ApplicationController
  before_action :logged_in_user
  before_action :load_user, only: [:index, :create]
  
  def index
    relationship = params[:relationship]
    @title = t "follow_user.#{relationship}"
    @users = @user.send(relationship).paginate page: params[:page]
  end

  def create
    current_user.follow @user
    respond_to do |format|
      format.html {redirect_to @user}
      format.js
    end
  end

  def destroy
    @user = Relationship.find(params[:id]).followed
    current_user.unfollow @user
    respond_to do |format|
      format.html {redirect_to @user}
      format.js
    end
  end

  private
  def load_user
    @user = User.find_by id: params[:id]
    if @user.nil?
      flash[:danger] = t "users.nil"
      redirect_to root_path
    end
  end
end
