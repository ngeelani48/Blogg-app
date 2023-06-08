class Post < ApplicationRecord
  belongs_to :author, class_name: 'User', foreign_key: :author_id, optional: true
  has_many :comments
  has_many :likes

  after_save :update_counter_posts

  def five_recent_comments
    comments.order(created_at: :desc).limit(5)
  end

  private

  def update_counter_posts
    author.update(posts_counter: author.posts.count)
  end
end
