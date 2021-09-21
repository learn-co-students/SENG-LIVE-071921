class UserEventsController < ApplicationController
  def create
    user_event = current_user.user_events.new(user_event_params)
    if user_event.save
      render json: user_event, status: :created
    else
      render json: user_event.errors, status: :unprocessable_entity
    end
  end

  private

  def user_event_params
    params.permit(:event_id)
  end
end
