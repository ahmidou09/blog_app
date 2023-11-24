class PostsController < ApplicationController
  before_action :find_user, only: %i[index show new create]
  load_and_authorize_resource

  def index
    authorize! :read, Post
    @posts = @user.posts.includes(:comments)
  end

  def show; end

  def new
    @user = current_user
  end

  def create
    @post = Post.create(post_params)
    @post.comments_counter = 0
    @post.likes_counter = 0
    @post = current_user.posts.new(post_params)
    if @post.save
      current_user.update(post_counter: current_user.posts.count)
      redirect_to user_posts_path(current_user), notice: 'Post created successfully.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @user = @post.user
    @post.comments.destroy_all
    @post.likes.destroy_all
    @user.decrement!(:post_counter)
    @post.destroy

    redirect_to user_posts_path(@user), notice: 'Post deleted successfully.'
  end

  private

  def find_user
    @user = User.find(params[:user_id])
  end

  def post_params
    params.require(:post).permit(:title, :text, :comments_counter, :likes_counter)
  end
end
