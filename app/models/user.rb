class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable
  has_many :posts, foreign_key: 'author_id'
  has_many :likes
  has_many :comments

  attribute :posts_counter, :integer

  validates :name, presence: true
  validates :posts_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  def return_recent_posts
    posts.order(created_at: :desc).limit(3)
  end

  def admin?
    role == 'admin'
  end
end
