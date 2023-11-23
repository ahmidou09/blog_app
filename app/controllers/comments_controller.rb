class CommentsController < ApplicationController
  before_action :find_user_and_post, only: %i[new create]
  before_action :find_comment, only: [:destroy]

  def new
    @comment = @post.comments.new
  end

  def create
    @comment = @post.comments.new(comment_params)
    @comment.user = @user

    if @comment.save
      redirect_to user_post_path(@user, @post), notice: 'Comment created successfully.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    authorize! :destroy, @comment

    @user = @comment.post.user
    @post = @comment.post

    @comment.destroy
    redirect_to user_post_path(@user, @post), notice: 'Comment deleted successfully.'
  end

  private

  def comment_params
    params.require(:comment).permit(:text)
  end

  def find_user_and_post
    @user = current_user
    @post = Post.find(params[:post_id])
  end

  def find_comment
    @comment = Comment.find(params[:id])
  end
end
