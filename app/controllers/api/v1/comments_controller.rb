class Api::V1::CommentsController < ApplicationController
  respond_to :json
  include ActionController::Cookies
  before_action :find_post
  before_action :info_current_user

  # -> create
  def create
    @new_comment = Comment.new(user_id: info_current_user.id, post_id: @post.id,
                               message: params[:message], rate: params[:rate])
    render "comment/create.json.jbuilder" if @new_comment.save
  end

  # -> delete
  def destroy
    @comment = Comment.find_by(user_id: info_current_user.id, post_id: @post.id)
    @comment&.delete
  end

  private

  def find_post
    @post = Post.find(params[:post_id])
  end
end
