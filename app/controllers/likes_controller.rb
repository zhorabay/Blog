class LikesController < ApplicationController
  def new
    @post = Post.find(params[:post_id])
    @like = Like.new
  end

  def create
    @post = Post.find(params[:post_id])
    @like = @post.likes.new(user: @user)

    if @like.save
      @post.update(likes_counter: @post.likes.count)
      redirect_to user_post_path(@post.author, @post), notice: 'You liked the post!'
    else
      redirect_to user_post_path(@post.author, @post), alert: 'Unable to like the post.'
    end
  end
end
