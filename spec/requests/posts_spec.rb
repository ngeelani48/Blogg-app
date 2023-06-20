require 'rails_helper'

RSpec.describe 'Posts', type: :request do
  describe 'GET #index' do
    it 'returns a successful response' do
      user = User.create(name: 'Stella', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Rusia.',
                         posts_counter: 0)
      get user_posts_path(user)
      expect(response).to have_http_status(:success)
    end

    it 'renders the index template' do
      user = User.create(name: 'Stella', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Rusia.',
                         posts_counter: 0)
      get user_posts_path(user)
      expect(response).to render_template(:index)
    end

    it 'includes correct placeholder text in the response body' do
      user = User.create(name: 'Stella', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Rusia.',
                         posts_counter: 0)
      get user_posts_path(user)
      expect(response.body).to include("#{user.name}")
    end
  end

  describe 'GET #show' do
    it 'returns a successful response' do
      user = User.create!(name: 'John Doe', photo: 'https://example.com/user1.jpg', bio: 'Teacher from Russia.',
                          posts_counter: 0)
      post = Post.create!(title: 'Test Post', text: 'This is a test post', author: user, comments_counter: 0,
                          likes_counter: 0)
      get user_post_path(user.id, post.id)
      expect(response).to have_http_status(:success)
    end

    it 'renders the show template' do
      user = User.create!(name: 'John Doe', photo: 'https://example.com/user1.jpg', bio: 'Teacher from Russia.',
                          posts_counter: 0)
      post = Post.create!(title: 'Test Post', text: 'This is a test post', author: user, comments_counter: 0,
                          likes_counter: 0)
      get user_post_path(user.id, post.id)
      expect(response).to render_template(:show)
    end

    it 'includes correct placeholder text in the response body' do
      user = User.create!(name: 'John Doe', photo: 'https://example.com/user1.jpg', bio: 'Teacher from Russia.',
                          posts_counter: 0)
      post = Post.create!(title: 'Test Post', text: 'This is a test post', author: user, comments_counter: 0,
                          likes_counter: 0)
      get user_post_path(user.id, post.id)
      expect(response.body).to include("#{post.title}")
    end
  end
end
