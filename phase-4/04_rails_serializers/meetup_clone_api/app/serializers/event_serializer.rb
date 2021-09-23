class EventSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :location, :start_time, :end_time, :creator, :current_user_is_going
  
  def creator
    object.user.username
  end

  def current_user_is_going
    current_user.events.include?(object)
  end
end
