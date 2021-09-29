class EventsController < ApplicationController
  def index
    events = Event.all.includes(:user_events)
    render json: events, each_serializer: EventIndexSerializer
  end

  def show
    event = Event.find(params[:id])
    render json: event
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
    event = current_user.events.find(params[:id])
    if event.update(event_params)
      render json: event, status: :ok
    else
      render json: event.errors, status: :unprocessable_entity
    end
  end

  def destroy
    event = current_user.created_events.find(params[:id])
    event.destroy
    # we'll render the event as json in case we want to enable undo functionality from the frontend.
    render json: event, status: :ok
  end

  private

  def event_params
    params.permit(:title, :description, :location, :start_time, :end_time, :group_name, :cover_image_url)
  end

end
