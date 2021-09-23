class UserEventsController < ApplicationController

  def index
    render json: current_user.user_events, status: :ok
  end

  def create
    user_event = current_user.user_events.new(user_event_params)
    if user_event.save
      render json: user_event, status: :created
    else
      render json: user_event.errors, status: :unprocessable_entity
    end
  end

  def update
    user_event = UserEvent.find(params[:id])
    if user_event.update(update_user_event_params)
      render json: user_event, status: :ok
    else
      render json: user_event.errors, status: :unprocessable_entity
    end
  end

  def destroy
    user_event = current_user.user_events.find(params[:id])
    user_event.destroy
  end

  private

  def user_event_params
    params.permit(:event_id)
  end

  def update_user_event_params
    params.permit(:attended)
  end
end