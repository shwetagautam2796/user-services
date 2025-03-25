class AuthenticationController < ApplicationController

  def validate_token
    token = request.headers['Authorization']&.split(' ')&.last

    if token.blank?
      render json: { error: "Token is missing" }, status: :unauthorized
      return
    end

    begin
      decoded_token = JsonWebToken.decode(token)  # Decode JWT
      user = User.find(decoded_token[:user_id])

      render json: { valid: true, user: { id: user.id, email: user.email } }, status: :ok
    rescue ActiveRecord::RecordNotFound
      render json: { valid: false, error: "User not found" }, status: :unauthorized
    rescue JWT::DecodeError
      render json: { valid: false, error: "Invalid token" }, status: :unauthorized
    end
  end
end
