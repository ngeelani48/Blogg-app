require 'rails_helper'

RSpec.describe 'Post Index Page', type: :feature do
  before do
    @user = User.create(name: 'John', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', posts_counter: 3)

    @first_post = Post.create(author: @user, title: 'First Post', text: 'This is my first post.', comments_counter: 0,
                              likes_counter: 0)
    @second_post = Post.create(author: @user, title: 'Second Post', text: 'This is my second post.',
                               comments_counter: 0, likes_counter: 0)
    @third_post = Post.create(author: @user, title: 'Third Post', text: 'This is my third post.', comments_counter: 0,
                              likes_counter: 0)

    Comment.create(author: @user, post: @first_post, text: 'I like it')
    Comment.create(author: @user, post: @second_post, text: 'Nice post')
    Like.create(author: @user, post: @third_post)
  end

  it 'displays the user profile' do
    visit user_posts_path(@user)
    expect(page).to have_css("img[src='https://unsplash.com/photos/F_-0BxGuVvo']")
    expect(page).to have_content('John')
    expect(page).to have_content('Number of posts: 3')
  end

  it 'displays the posts' do
    visit user_posts_path(@user)
    expect(page).to have_content('First Post')
    expect(page).to have_content('This is my first post.')
    expect(page).to have_content('Second Post')
    expect(page).to have_content('This is my second post.')
    expect(page).to have_content('Third Post')
    expect(page).to have_content('This is my third post.')
  end

  it 'displays the comments and likes data for each post' do
    visit user_posts_path(@user)
    expect(page).to have_content('Comment: 1, Likes: 0')
    expect(page).to have_content('Comment: 1, Likes: 0')
    expect(page).to have_content('Comment: 0, Likes: 1')
  end

  it 'displays the first comments on a post' do
    visit user_posts_path(@user)
    expect(page).to have_selector('.comments-container-index li', text: "#{@user.name}: I like it")
    expect(page).to have_selector('.comments-container-index li', text: "#{@user.name}: Nice post")
    expect(page).to have_selector('.comments-container-index li', text: 'No comments added yet...')
  end

  it 'redirects to a post show page when clicking on a post' do
    visit user_posts_path(@user)
    click_link('First Post')
    expect(current_path).to eq(user_post_path(@user, @first_post))
  end

  it 'displays a section for pagination' do
    visit user_posts_path(@user)
    expect(page).to have_selector('.pagination')
  end
end
