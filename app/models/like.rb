class Like < ApplicationRecord
    belongs_to :author, foreign_key: :author_id
    belongs_to :post
  
    def udate_counter_likes
      author.update(likes_counter: author.likes.count)
    end
  end