class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.includes(:posts).all
  end

  def show
    @user = User.includes(posts: :author).find_by(id: params[:id])
    redirect_to users_path, alert: 'User not found' unless @user
  end
end
