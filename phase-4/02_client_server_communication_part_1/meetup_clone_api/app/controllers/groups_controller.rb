class GroupsController < ApplicationController
  def index
    groups = Group.all
    render json: groups
  end

  def show
    render json: Group.find(params[:id]), include: :events
  end
end
