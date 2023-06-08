require '../rails_helper'

RSpec.describe Post, type: :model do
  subject do
    User.create(name: 'John', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Student')
    Post.new(title: 'Hello', text: 'This is a post', comments_counter: 0, likes_counter: 0, author_id: User.first.id)
  end

  before { subject.save }

  context 'Validations' do
    it 'should be valid with valid attributes' do
      expect(subject).to be_valid
    end

    it 'should not be valid without a title' do
      subject.title = nil
      expect(subject).to_not be_valid
    end

    it 'should not be valid if the title exceeds 250 characters' do
      subject.title = 'a' * 251
      expect(subject).to_not be_valid
    end

    it 'should have a comments_counter greater than or equal to zero' do
      expect(subject).to be_valid
      subject.comments_counter = -1
      expect(subject).to_not be_valid
    end

    it 'should have a likes_counter greater than or equal to zero' do
      expect(subject).to be_valid
      subject.likes_counter = -1
      expect(subject).to_not be_valid
    end
  end

  context 'Behavior' do
    let(:post) { subject }

    before do
      5.times do
        Comment.create!(post:, author_id: User.first.id, text: 'Nice post')
      end
    end

    it 'should return the five most recent comments' do
      expect(post.five_recent_comments.count).to eq(5)
    end

    it 'should update the author\'s posts_counter after saving' do
      expect(User.first.posts_counter).to eq(1)
      Post.create!(title: 'New Post', text: 'This is a new post', comments_counter: 0, likes_counter: 0,
                   author_id: User.first.id)
      expect(User.first.posts_counter).to eq(2)
    end
  end
end
