require_relative '../rails_helper'

RSpec.describe Comment, type: :model do
  let(:user) do
    User.create(name: 'John', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher in school',
                posts_counter: 0)
  end

  let(:post) do
    Post.create(title: 'Hello Test', text: 'This is a test post', author: user, comments_counter: 0,
                likes_counter: 0)
  end

  subject do
    Comment.new(text: 'This is a test comment', author: user, post:)
  end

  describe 'Callbacks' do
    it 'updates the post comments_counter after saving' do
      expect { subject.save }.to change { post.comments_counter }.by(1)
    end
  end
end
