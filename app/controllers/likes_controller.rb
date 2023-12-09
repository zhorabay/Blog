class LikesController < ApplicationController
  before_action :current_user

  def create
    @user = current_user
    @post = Post.find(params[:post_id])
    @like = @post.likes.new(user: @user)

    if @like.save
      redirect_to user_post_path(@post.author, @post), notice: 'You liked the post!'
    else
      redirect_to user_post_path(@post.author, @post), alert: 'Unable to like the post.'
    end
  end
end
