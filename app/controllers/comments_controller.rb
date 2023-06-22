class CommentsController < ApplicationController
  def create
    @user = current_user
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build(comment_params)
    @comment.author = @user

    if @comment.save
      redirect_to user_post_path(@user, @post), notice: 'Comment was successfully created.'
    else
      redirect_to user_post_path(@user, @post), alert: 'Failed to create comment.'
    end
  end

  def destroy
    @user = User.find(params[:user_id])
    @post = Post.find(params[:post_id])
    @comment = Comment.find(params[:id])
    authorize! :delete, @comment

    if @comment.destroy
      redirect_to user_post_path(@user, @post), notice: 'Comment was successfully deleted.'
    else
      redirect_to user_post_path(@user, @post), alert: 'Failed to delete the comment.'
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:text)
  end
end
