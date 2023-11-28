class Post < ApplicationRecord
  belongs_to :author, class_name: 'User', foreign_key: 'author_id'
  has_many :likes
  has_many :comments

  validates :title, presence: true
  validates :text, presence: true

  def update_posts_counter
    author.update(posts_counter: author.posts.count)
  end

  def return_recent_comments
    comments.order(created_at: :desc).limit(5)
  end
end