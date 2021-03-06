class SessionsController < Devise::SessionsController
  respond_to :json
  before_action :configure_devise_params, if: :devise_controller?

  def create
    @user = User.where(profile: Admin.where(username: params[:admin][:username]))[0] if params[:admin]
    @user = User.where(profile: Guest.where(username: guest_params[:username]))[0] if params[:guest]

    if @user.valid_password?(sign_in_params[:password])
      token = encode_token({ user_id: @user.id, token: "token" })
      cookies[:token] = { value: token, httponly: true, site: :none, secure: Rails.env.production? }

      render "sessions/logged?.json.jbuilder"
    else
      render json: { message: "Wrong email or password" }
    end
  end

  def logged?
    render json: { message: "Forbitten Route" } unless cookies[:token]
    return unless cookies[:token]

    token = JWT.decode(cookies[:token], ENV["DEVISE_JWT_SECRET_KEY"])
    @user = User.find(token[0]["user_id"]) || nil
    render "sessions/logged?.json.jbuilder"
  end

  def delete
    cookies.delete :token
    render json: { message: "Log Out Success" }
  end

  private

  def guest_params
    params.require(:guest).permit(:username, :password)
  end

  def respond_with(resource, _opts = {})
    render json: resource
  end

  def respond_to_on_destroy
    head :ok
  end

  protected

  def configure_devise_params
    devise_parameter_sanitizer.permit(:sign_in, keys: [:username])
  end
end
