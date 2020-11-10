class Api::UsersController < ApplicationController

  # -> GET /users
  def index
    @user = User.all
    render json: @user
  end

  # -> GET /users/:id
  def show
    @user = User.find(params[:id])
    if @user
      render json: @user
    else
      render error: {error: "Unable to create User."}, status: 400
    end
  end

  # -> POST /users
  def create
    @user = User.new(user_params)
    if @user.save
      render json: @user
    else
      render error: {error: "Unable to create User."}, status: 400
    end
  end

  # -> PUT /users/:id
  def update
    @user = User.find(params[:id])
    if @user
      @user.update(user_params)
      render json: {message: "User successfully updated."}, status: 200
    else
      render json: {error: "Unable to update User."}, status: 400
    end
  end

  # -> DELETE /users/:id
  def delete
    @user = User.find(params[:id])
    if @user
      @user.update(@user.status = false)
      render json: {message: "User successfully deleted"}, status: 200
    else
      render json: {error: "Unable to delete User."}, status: 400
    end
  end

  # private defs

  private

  def user_params
    params.require(:user).permit(:name, :email, :password)
  end
end
