require 'rails_helper'

RSpec.feature 'Post Show Page', type: :feature do
  let!(:user) { User.create(name: 'Tom', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', posts_counter: 3) }
  let!(:post) do
    Post.create(author: user, title: 'First Post', text: 'This is my first post.', comments_counter: 0,
                likes_counter: 0)
  end
  let!(:comment1) { Comment.create(author: user, post:, text: 'I like it') }
  let!(:comment2) { Comment.create(author: user, post:, text: 'Nice post') }

  scenario 'User can see post details and comments' do
    visit user_post_path(user, post)

    expect(page).to have_content(post.title)
    expect(page).to have_content("by #{user.name}")
    expect(page).to have_content('Comments: 2')
    expect(page).to have_content("Likes: #{post.likes_counter}")
    expect(page).to have_content(post.text)

    expect(page).to have_content("#{comment1.author.name}: #{comment1.text}")
    expect(page).to have_content("#{comment2.author.name}: #{comment2.text}")
  end

  scenario 'User can add a comment to the post' do
    visit user_post_path(user, post)

    fill_in 'Add a comment...', with: 'This is a new comment'
    click_button 'Add Comment'

    expect(page).to have_content("#{user.name}: This is a new comment")
  end

  scenario 'User can like the post' do
    visit user_post_path(user, post)

    click_button 'Like'

    post.reload # Reload the post object to get the updated likes count

    expect(page).to have_content("Likes: #{post.likes_counter}")
  end
end
