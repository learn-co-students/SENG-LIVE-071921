class UserGroupsController < ApplicationController
  def index
    render json: current_user.user_groups, status: :ok
  end

  def create
    user_group = current_user.user_groups.new(user_group_params)
    if user_group.save
      render json: user_group, status: :created
    else
      render json: user_group.errors, status: :unprocessable_entity
    end
  end

  def destroy
    user_group = current_user.user_groups.find(params[:id])
    user_group.destroy
    render json: user_group, status: :ok
  end

  private

  def user_group_params
    params.permit(:group_id)
  end
end
