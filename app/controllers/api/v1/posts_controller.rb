class Api::V1::PostsController < ApplicationController
  respond_to :json
  include ActionController::Cookies
  before_action :info_current_user

  # -> define pagination
  POSTS_PER_PAGE = 12

  # -> index
  def index
    @page = params.fetch(:page, 0).to_i # to integer
    @posts = Post.page(@page).per(POSTS_PER_PAGE).order(:created_at)
    render 'post/index' if @posts
  end

  # -> show
  def show
    @post = Post.find(params[:id])
    render json: @post if @post
  end

  # -> create
  def create
    @new_post = Post.new(post_params)
    render json: @new_post if @new_post.save
  end

  # -> update
  def update
    @post = Post.find(params[:id])
    render json: @post if @post&.update(post_params)
  end

  # -> delete
  def destroy
    @post = Post.find(params[:id])
    @post&.delete
  end

  private

  def post_params
    params[:post].permit(:title, :author, :co_author, :download_link, :body)
  end
end
