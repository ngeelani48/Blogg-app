class UsersController < ApplicationController
  def show
    @user = User.includes(posts: [:comments, :likes]).find(params[:id])
    @posts = @user.posts
  end

  def index
    @users = User.includes(:posts)
  end
end
