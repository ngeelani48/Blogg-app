class PostsController < ApplicationController
  load_and_authorize_resource
  def index
    @user = User.includes(post: %i[comments likes]).find(params[:user_id])
    @posts = @user.post.paginate(page: params[:page], per_page: 10)
  end

  def show
    @user = User.includes(post: %i[comments likes]).find(params[:user_id])
    @post = Post.includes(:comments).find(params[:id])
    @comments = @post.comments
  end

  def new
    @user = current_user
    @post = @user.post.new
  end

  def create
    @post = Post.new(title: post_params[:title], text: post_params[:text], author_id: current_user[:id],
                     comments_counter: 0, likes_counter: 0)

    if @post.save
      redirect_to user_post_path(current_user, @post), notice: 'Post was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @post = Post.find(params[:id])
    authorize! :delete, @post

    if @post.destroy
      redirect_to user_path(current_user), notice: 'Post was successfully deleted.'
    else
      redirect_to user_path(current_user), alert: 'Failed to delete the post.'
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :text)
  end
end
