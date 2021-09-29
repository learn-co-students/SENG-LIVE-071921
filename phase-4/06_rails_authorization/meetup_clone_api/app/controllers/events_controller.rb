class EventsController < ApplicationController
  before_action :set_event, only: [:show, :update, :destroy]
  before_action :authorize_user, only: [:update, :destroy]
  
  def index
    events = Event.all.includes(:user_events)
    render json: events, each_serializer: EventIndexSerializer
  end

  def show
    render json: @event
  end

  def create
    event = current_user.created_events.new(event_params)
    if event.save
      render json: event, status: :created
    else
      render json: event.errors, status: :unprocessable_entity
    end
  end

  def update
    if @event.update(event_params)
      render json: @event, status: :ok
    else
      render json: @event.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @event.destroy
    # we'll render the event as json in case we want to enable undo functionality from the frontend.
    render json: event, status: :ok
  end

  private

  def event_params
    params.permit(:title, :description, :location, :start_time, :end_time, :group_name, :cover_image_url)
  end

  def set_event
    @event = Event.find(params[:id])
  end

  def authorize_user
    user_can_modify = current_user.admin? || @event.user_id == current_user.id
    return render json: { error: "You don't have permission to perform that action" }, status: :forbidden unless user_can_modify
  end

end
