class PostsController < ApplicationController
  before_action :find_post, only: [:show]
  helper_method :current_user

  def index
    @user = User.find(params[:user_id])
    @posts = @user.posts.includes(:comments).paginate(page: params[:page], per_page: 6)
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @user = current_user
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)

    if @post.save
      redirect_to user_post_path(@user, @post), notice: 'Post created successfully.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :text)
  end

  def find_post
    @post = Post.find(params[:id])
  end

  def current_user
    @current_user = User.find(session[:user_id]) if session[:user_id]
  end
end
