class CommentsController < ApplicationController
  before_action :current_user

  def create
    @user = current_user
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build(comment_params.merge(post: @post))

    if @comment.save
      redirect_to user_post_path(@user, @post), notice: 'Comment added successfully!'
    else
      redirect_to user_post_path(@user, @post), alert: 'Unable to add the comment.'
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:text)
  end
end
