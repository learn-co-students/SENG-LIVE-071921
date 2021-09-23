class GroupsController < ApplicationController
  def index
    groups = Group.all
    render json: groups, each_serializer: GroupIndexSerializer
  end

  def show
    render json: Group.find(params[:id]), serializer: GroupShowSerializer
  end

  def create
    group = Group.new(group_params)
    if group.save
      render json: group, status: :created
    else
      render json: group.errors, status: :unprocessable_entity
    end
  end

  private

  def group_params
    params.permit(:name, :location)
  end
end
