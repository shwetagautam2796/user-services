class UsersController < ApplicationController
  def show
    user = User.find(params[:id])
    render json: { id: user.id, email: user.email }
  end
end
