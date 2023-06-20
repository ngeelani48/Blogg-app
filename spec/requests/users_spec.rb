require 'rails_helper'

RSpec.describe UsersController, type: :request do
  describe 'GET #show' do
    it 'returns a successful response' do
      user = User.create(name: 'Lyn', photo: 'https://unsplash.com/photos/7fF0iei80AQ', bio: 'Teacher from England.',
                         posts_counter: 0)
      get user_path(user.id)
      expect(response).to have_http_status(:success)
    end

    it 'renders the show template' do
      user = User.create(name: 'Lyn', photo: 'https://unsplash.com/photos/7fF0iei80AQ', bio: 'Teacher from England.',
                         posts_counter: 0)
      get user_path(user.id)
      expect(response).to render_template(:show)
    end

    it 'includes correct placeholder text in the response body' do
      user = User.create(name: 'Lyn', photo: 'https://unsplash.com/photos/7fF0iei80AQ', bio: 'Teacher from England.',
                         posts_counter: 0)
      get user_path(user.id)
      expect(response.body).to include(user.name.to_s)
    end
  end

  describe 'GET #index' do
    it 'returns a successful response' do
      get users_path
      expect(response).to have_http_status(:success)
    end

    it 'renders the index template' do
      get users_path
      expect(response).to render_template(:index)
    end

    it 'includes correct placeholder text in the response body' do
      User.create(name: 'Lyn', photo: 'https://unsplash.com/photos/7fF0iei80AQ', bio: 'Teacher from England.',
                  posts_counter: 0)
      User.create(name: 'John Doe', photo: 'https://unsplash.com/photos/ABC123', bio: 'Lorem ipsum', posts_counter: 0)
      get users_path
      expect(response.body).to include('Users')
    end
  end
end
