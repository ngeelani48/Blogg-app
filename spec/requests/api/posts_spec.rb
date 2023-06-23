require 'swagger_helper'

RSpec.describe 'Posts API', type: :request do
  path '/api/users/{user_id}/posts' do
    get 'Retrieve all posts for a user' do
      tags 'Posts'
      parameter name: 'user_id', in: :path, type: :string, description: 'User ID'

      response '200', 'OK' do
        let(:user) { create(:user) } # Assuming you have a factory for user creation

        before { create_list(:post, 5, user:) } # Assuming you have a factory for post creation

        run_test!
      end

      response '404', 'User not found' do
        let(:user_id) { 'invalid' }

        run_test!
      end

      response '422', 'Unprocessable Entity' do
        # Add additional error response details if needed
        run_test!
      end
    end
  end
end
