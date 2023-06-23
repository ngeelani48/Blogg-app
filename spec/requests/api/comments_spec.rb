require 'swagger_helper'

RSpec.describe 'Comments API', type: :request do
  path '/api/users/{user_id}/posts/{post_id}/comments' do
    get 'Retrieve all comments for a post' do
      tags 'Comments'
      parameter name: 'user_id', in: :path, type: :string, description: 'User ID'
      parameter name: 'post_id', in: :path, type: :string, description: 'Post ID'

      response '200', 'OK' do
        let(:user) { create(:user) } # Assuming you have a factory for user creation
        let(:post) { create(:post, user:) } # Assuming you have a factory for post creation

        before { create_list(:comment, 5, post:) } # Assuming you have a factory for comment creation

        run_test!
      end

      # Add error response documentation for 404 and 422 if needed
    end

    post 'Create a comment for a post' do
      tags 'Comments'
      parameter name: 'user_id', in: :path, type: :string, description: 'User ID'
      parameter name: 'post_id', in: :path, type: :string, description: 'Post ID'
      parameter name: :comment, in: :body, schema: {
        type: :object,
        properties: {
          text: { type: :string }
        },
        required: ['text']
      }

      response '201', 'Created' do
        let(:user) { create(:user) } # Assuming you have a factory for user creation
        let(:post) { create(:post, user:) } # Assuming you have a factory for post creation
        let(:comment) { { text: 'This is a comment' } }

        run_test!
      end

      response '422', 'Unprocessable Entity' do
        let(:user_id) { 'invalid' }
        let(:post_id) { 'invalid' }
        let(:comment) { { text: '' } } # Invalid comment data

        run_test!
      end
    end
  end
end
