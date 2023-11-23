class PostsController < ApplicationController
  before_action :find_user, only: %i[index show new create]
  before_action :find_post, only: %i[show destroy]

  def index
    @posts = @user.posts.includes(:comments)
  end

  def find_user
    @user = User.find(params[:user_id])
  end

  def show
    @post = @user.posts.find(params[:id])
  end

  def new
    @user = current_user
    @post = @user.posts.new
  end

  def create
    @post = current_user.posts.new(post_params)
    if @post.save
      current_user.update(post_counter: current_user.posts.count)
      redirect_to user_posts_path(current_user), notice: 'Post created successfully.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  
