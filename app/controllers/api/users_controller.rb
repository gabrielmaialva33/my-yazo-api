class Api::UsersController < ApplicationController

  USERS_PER_PAGE = 3

  # -> GET /users
  def index
    @page = params.fetch(:page, 0).to_i # to integer
    @user = User.where(status: true).offset(@page).limit(USERS_PER_PAGE)
    render json: @user
  end

  # -> GET /users/:id
  def show
    return render json: { error: 'Incorrect params.' }, status: 400 if UUID.validate(params[:id]).nil?

    @user = User.find(params[:id])
    if @user
      render json: @user
    else
      render error: { error: 'Unable to create User.' }, status: 400
    end
  end

  # -> POST /users
  def create
    @user = User.new(user_params)
    if @user.save
      render json: @user
    else
      render error: { error: 'Unable to create User.' }, status: 400
    end
  end

  # -> PUT /users/:id
  def update
    return render json: { error: 'Incorrect params.' }, status: 400 if UUID.validate(params[:id]).nil?

    @user = User.find(params[:id])
    if @user
      @user.update(user_params)
      render json: { message: 'User successfully updated.' }, status: 200
    else
      render json: { error: 'Unable to update User.' }, status: 400
    end
  end

  # -> DELETE /users/:id -> change email
  def delete
    return render json: { error: 'Incorrect params.' }, status: 400 if UUID.validate(params[:id]).nil?

    @user = User.find(params[:id])
    if @user
      @user.update({ status: false })
      render json: { message: 'User successfully deleted' }, status: 200
    else
      render json: { error: 'Unable to delete User.' }, status: 400
    end
  end

  # private defs

  private

  def user_params
    params.require(:user).permit(:name, :email, :password)
  end
end

