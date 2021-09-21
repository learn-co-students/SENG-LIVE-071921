class GroupsController < ApplicationController
  def index
    groups = Group.all
    render json: groups
  end

  def show
    group = Group.find_by(id: params[:id])
    render json: group, include: :events
  end
end
