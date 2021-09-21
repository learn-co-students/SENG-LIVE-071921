class EventsController < ApplicationController
  def index
    events = Event.all
    render json: events
  end

  def show  
    render json: Event.find(params[:id]), include: :attendees
  end
end
