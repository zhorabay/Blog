class PostsController < ApplicationController
  before_action :find_post, only: [:show]
  before_action :current_user

  def index
    @user = User.find(params[:user_id])
    @posts = @user.posts.includes(:comments).paginate(page: params[:page], per_page: 6)
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @user = current_user
    @post = @user.posts.build
  end

  def create
    @user = current_user
    @post = @user.posts.build(post_params)

    if @post.save
      redirect_to user_post_path(@user, @post), notice: 'Post created successfully.'
    else
      redirect_to user_post_path(@user, @post), alert: 'Unable to create the post.'
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :text)
  end

  def find_post
    @post = Post.find_by(id: params[:id])

    unless @post
      redirect_to users_path, alert: 'Post not found'
    end
  end
end
