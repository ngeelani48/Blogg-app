class Post < ApplicationRecord
  belongs_to :author, foreign_key: :author_id
  has_many :comments
  has_many :likes

  def update_counter_posts
    author.update(posts_counter: author.posts.count)
  end
end
