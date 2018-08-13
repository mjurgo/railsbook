class PostsController < ApplicationController

  def index
    @posts = Post.order(created_at: :desc)
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      redirect_to posts_path, notice: "Post added!"
    else
      redirect_to posts_path, notice: "Sorry! Post couldn't be created!"
    end
  end


  private

    def post_params
      params.require(:post).permit(:content)
    end
end
