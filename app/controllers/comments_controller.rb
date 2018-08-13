class CommentsController < ApplicationController

  def create
    puts "="*50
    @comment = @commentable.comments.new(comment_params)
    @comment.author = current_user
    @comment.save
    redirect_to @commentable, notice: "Comment successfully posted!"
  end

  private

    def comment_params
      params.require(:comment).permit(:content)
    end

end

