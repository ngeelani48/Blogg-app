class Post < ApplicationRecord
  belongs_to :author, class_name: 'User', foreign_key: :author_id, optional: true
  has_many :comments
  has_many :likes

  validates :title, presence: true, length: { maximum: 250 }
  validates :comments_counter, :likes_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  after_commit :update_counter_posts, on: :create

  def five_recent_comments
    comments.order(created_at: :desc).limit(5)
  end

  private

  def update_counter_posts
    User.update_counters(author_id, posts_counter: 1)
  end
end
