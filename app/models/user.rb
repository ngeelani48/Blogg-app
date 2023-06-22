class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

  has_many :post, foreign_key: 'author_id'
  has_many :like, foreign_key: 'author_id'
  has_many :comment, foreign_key: 'author_id'

  validates :name, presence: true
  validates :posts_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  after_initialize :set_default_post_counter

  def set_default_post_counter
    self.posts_counter ||= 0
  end

  def three_recent_posts
    post.order(created_at: :desc).limit(3)
  end
end
