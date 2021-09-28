class UsersController < ApplicationController

  def show
    if current_user
      render json: current_user, status: :ok
    else
      render json: {}, status: :unauthorized
    end
  end 

  def create
    user = User.create(user_params)
    if user.valid?
      session[:user_id] = user.id
      render json: user, status: :created
    else
      render json: { error: user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.permit(:username, :password, :password_confirmation)
  end
end
