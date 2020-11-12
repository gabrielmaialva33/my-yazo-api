class Api::V1::UsersController < ApplicationController
  # -> define
  USERS_PER_PAGE = 3

  # -> index
  def index
    @page = params.fetch(:page, 0).to_i # to integer
    @user = User.where(status: true).offset(@page).limit(USERS_PER_PAGE)
    render json: @user
  end

  # -> show
  def show
    # return render json: { error: 'Incorrect params.' }, status: 400 if UUID.validate(params[:id]).nil?
    @user = User.find(params[:id])
    if @user
      render json: @user
    else
      render error: { error: "Unable to show User." }, status: 400
    end
  end

  # -> create
  def create
    @user = User.new(user_params)
    if @user.save
      render json: @user
    else
      render json: { message: "Unable to create User.", errors: @user.errors.full_messages, params: user_params }, status: 400
    end
  end

  # -> update
  def update
    @user = User.find(params[:id])
    if @user
      @user.update(user_params)
      render json: { message: "User successfully updated." }, status: 200
    else
      render json: { error: "Unable to update User." }, status: 400
    end
  end

  # -> destroy
  def destroy
    @user = User.find(params[:id])
    if @user
      @user.update({ status: false })
      render json: { message: "User successfully deleted" }, status: 200
    else
      render json: { message: "Unable to delete User." }, status: 400
    end
  end

  private

  def user_params
    params.permit(:name, :email, :password, :password_confirmation)
  end
end
