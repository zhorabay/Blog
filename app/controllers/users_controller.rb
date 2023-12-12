class UsersController < ApplicationController
  def index
    @users = User.includes(:posts).all
  end

  def show
    @user = User.includes(posts: :author).find_by(id: params[:id])
    redirect_to users_path, alert: 'User not found' unless @user
  end
end
