require 'rails_helper'

RSpec.describe User, type: :model do
  subject do
    User.new(name: 'Sam', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Student', posts_counter: 0)
  end

  before { subject.save }

  context 'Testing validations' do
    it 'name should be present' do
      expect(subject).to be_valid
      subject.name = nil
      expect(subject).to_not be_valid
    end

    it 'posts_counter should be a non-negative integer' do
      expect(subject).to be_valid
      subject.posts_counter = -5
      expect(subject).to_not be_valid
    end
  end

  context 'Testing behavior' do
    let(:user) { subject }

    before do
      5.times do
        Post.create!(author: user, title: 'Hello World', text: 'Text', comments_counter: 1, likes_counter: 1)
      end
    end

    it 'lists the 3 most recent posts' do
      expect(user.three_recent_posts.count).to eq(3)
    end
  end
end
