class Api::PostsController < ApplicationController
  before_action :set_user, only: [:index]

  def index
    @posts = @user.posts
    render json: @posts
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end

  def post_params
    params.require(:post).permit(:title, :text)
  end
end
