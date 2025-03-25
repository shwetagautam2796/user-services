# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  skip_before_action :authorize_request, only: [:create] # Skip authorization for login

  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end

  def create
    user = User.find_by(email: params[:email])

    if user&.valid_password?(params[:password])
      token = JsonWebToken.encode({ user_id: user.id })  # Encode user ID in token
      render json: { token: token, user: { id: user.id, email: user.email} }, status: :ok
    else
      render json: { error: "Invalid email or password" }, status: :unauthorized
    end
  end
end
