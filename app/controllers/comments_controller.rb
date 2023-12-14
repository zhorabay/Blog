class CommentsController < ApplicationController
  before_action :current_user
  before_action :set_post, only: %i[new create]

  def new
    @user = current_user
    @comment = Comment.new
  end

  def create
    @user = current_user
    @comment = @post.comments.build(comment_params.merge(user: @user))

    if @comment.save
      redirect_to user_post_path(@user, @post), notice: 'Comment added successfully!'
    else
      redirect_to user_post_path(@user, @post), alert: 'Unable to add the comment.'
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @post = @comment.post
    @user = @post.author
    @comment.destroy
    @post.comments_counter -= 1

    redirect_to user_post_path(@user, @post) if @post.save
  end

  private

  def set_post
    @post = Post.find(params[:post_id])
  end

  def comment_params
    params.require(:comment).permit(:text)
  end
end
