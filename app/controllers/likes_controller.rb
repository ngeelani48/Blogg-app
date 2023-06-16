class LikesController < ApplicationController
    def create
      @user = current_user
      @post = Post.find(params[:post_id])
      @like = @post.likes.build(author: @user)
  
      if @like.save
        redirect_to user_post_path(@user, @post), notice: 'Like was successfully added.'
      else
        redirect_to user_post_path(@user, @post), alert: 'Failed to add like.'
      end
    end
  end
  