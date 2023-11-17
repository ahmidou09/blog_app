class LikesController < ApplicationController
  before_action :set_user_and_post, only: [:create]

  def create
    @like = @post.likes.new(user: @user)

    if @like.save
      redirect_to user_post_path(@user, @post), notice: 'Post liked successfully.'
    else
      redirect_to user_post_path(@user, @post), alert: 'Failed to like the post.'
    end
  end

  private

  def set_user_and_post
    @user = current_user
    @post = Post.find(params[:post_id])
  end
end
