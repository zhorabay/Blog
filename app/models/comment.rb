class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post

  after_commit :update_comments_counter, on: :create

  private

  def update_comments_counter
    return unless post.present?

    post.update(comments_counter: post.comments.count)
  end
end
