class EventsController < ApplicationController
  def index
    events = Event.all
    render json: events
  end

  def show
    event = Event.find(params[:id])
    render json: event, include: :attendees
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
    event = current_user.created_events.find(params[:id])
    if event.update(event_params)
      render json: event, status: :ok
    else
      render json: event.errors, status: :unprocessable_entity
    end
  end

  def destroy
    event = current_user.created_events.find(params[:id])
    event.destroy
  end

  private

  def event_params
    params.permit(:title, :description, :location, :start_time, :end_time, :group_id)
  end
end
