require 'rails_helper'

RSpec.describe 'User Show Page', type: :feature do
  before do
    @user = User.create(
      name: 'John',
      photo: 'https://unsplash.com/photos/F_-0BxGuVvo',
      bio: 'Teacher in school',
      posts_counter: 3
    )
    
    @post1 = @user.posts.create(
      title: 'First Post',
      text: 'This is my first post.',
      comments_counter: 2,
      likes_counter: 5
    )

    @post2 = @user.posts.create(
      title: 'Second Post',
      text: 'This is my second post.',
      comments_counter: 0,
      likes_counter: 3
    )

    @post3 = @user.posts.create(
      title: 'Third Post',
      text: 'This is my third post.',
      comments_counter: 1,
      likes_counter: 2
    )
  end

  it 'displays the user profile picture' do
    visit user_path(@user)
    expect(page).to have_css("img[src='https://unsplash.com/photos/F_-0BxGuVvo']")
  end

  it 'displays the user username' do
    visit user_path(@user)
    expect(page).to have_content('John')
  end

  it 'displays the number of posts the user has written' do
    visit user_path(@user)
    expect(page).to have_content('Number of posts: 3')
  end

  it 'displays the user bio' do
    visit user_path(@user)
    expect(page).to have_content('Teacher in school')
  end

  it 'displays the first 3 posts of the user' do
    visit user_path(@user)
    expect(page).to have_content('First Post')
    expect(page).to have_content('This is my first post.')
    expect(page).to have_content('Second Post')
    expect(page).to have_content('This is my second post.')
    expect(page).to have_content('Third Post')
    expect(page).to have_content('This is my third post.')
  end

  it 'redirects to a post show page when clicking on a post' do
    visit user_path(@user)
    click_link(@post1.title)
    expect(current_path).to eq(user_post_path(@user, @post1))
  end
  
  it 'redirects to the user posts index page when clicking on "See all posts"' do
    visit user_path(@user)
    click_link('See all posts')
    expect(current_path).to eq(user_posts_path(@user))
  end
end