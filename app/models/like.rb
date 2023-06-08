class Like < ApplicationRecord
  belongs_to :author, class_name: 'User', foreign_key: :author_id
  belongs_to :post

  after_save :udate_counter_likes

  def udate_counter_likes
    post.update(likes_counter: post.likes.count)
  end

  private

  def update_counter_likes
    post.update(likes_counter: post.likes.count)
  end
end
