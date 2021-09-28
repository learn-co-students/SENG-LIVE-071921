class ApplicationController < ActionController::API

  private

  def current_user
    User.first
  end
end
