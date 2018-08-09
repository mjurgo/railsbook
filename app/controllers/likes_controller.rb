class LikesController < ApplicationController

  def like
    @user = current_user
    @post = Post.find(params[:post_id])
    @user.like!(@post)
  end

  def dislike
    @user = current_user
    @like = @user.likes.find_by(post_id: params[:post_id])
    @post = Post.find(params[:post_id])
    @like.destroy!
  end
end
