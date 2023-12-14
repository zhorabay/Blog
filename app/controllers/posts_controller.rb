class PostsController < ApplicationController
  load_and_authorize_resource

  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_current_user, only: [:new, :create]
  before_action :find_post, only: [:show]

  def index
    @user = User.find(params[:user_id])
    @posts = @user.posts.includes(:comments).paginate(page: params[:page], per_page: 3)
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

  def destroy
    @post = Post.find(params[:id])
    @user = @post.author
    @post.comments.destroy_all
    @post.likes.destroy_all
    @post.destroy
    @user.posts_counter -= 1
  
    if @user.save
      redirect_to user_posts_path(@user), notice: 'Post deleted successfully.'
    else
      redirect_to user_posts_path(@user), alert: 'Unable to delete the post.'
    end
  end

  private

  def set_current_user
    @user = current_user
  end

  def post_params
    params.require(:post).permit(:title, :text)
  end

  def find_post
    @post = Post.find_by(id: params[:id])
    redirect_to users_path, alert: 'Post not found' unless @post
  end
end
