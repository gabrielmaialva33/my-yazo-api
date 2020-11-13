class Api::V1::UsersController < ApplicationController
  respond_to :json
  include ActionController::Cookies
  before_action :info_current_user

  USER_PER_PAGE = 5

  # -> index
  def index
    return render json: { message: 'User not permitted' }, status: 401 if info_current_user.profile_type != 'Admin'

    @page = params.fetch(:page, 0).to_i # to integer
    @users = User.where(status: true).page(@page).per(USER_PER_PAGE).order(:created_at)
    render 'user/index' if @users
  end

  # -> show
  def show
    return render json: { error: 'Unable to show User.' }, status: 404 unless info_current_user

    @user = User.find_by(id: params[:id])
    render 'user/show' if @user
  end

  # -> update
  def update
    return render json: { message: 'User not permitted' }, status: 401 if info_current_user.profile_type != 'Admin'

    @user = User.find(params[:id])
    render json: { message: 'User successfully updated.' }, status: 200 if @user.update(user_params)
  end

  # -> delete
  def destroy
    return render json: { message: 'User not permitted' }, status: 401 if info_current_user.profile_type != 'Admin'

    @user = User.find(params[:id])
    @delete = @user.email = "##{@user.id}" + @user.email
    @user.update({ status: false, email: @delete })
    render json: { message: 'User successfully deleted' }, status: 204 if @user
  end

  private

  def user_params
    params.permit(:email, :password, :password_confirmation)
  end
end
