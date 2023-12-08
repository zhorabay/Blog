class CommentsController < ApplicationController
  def new
    @post = Post.find(params[:post_id])
    @comment = Comment.new
  end

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build(comment_params.merge(post: @post))

    if @comment.save
      @post.update(comments_counter: @post.comments.count)
      redirect_to user_post_path(@post.author, @post)
    else
      redirect_to user_post_path(@post.author, @post), alert: 'Unable to add the comment.'
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:text)
  end
end
