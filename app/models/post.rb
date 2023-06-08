class Post < ApplicationRecord
  belongs_to :author, class_name: 'User', foreign_key: :author_id, optional: true
  has_many :comments
  has_many :likes

  def update_counter_posts
    author.update(posts_counter: author.posts.count)
  end
end
