class EventSerializer < EventIndexSerializer
  has_many :attendees
  belongs_to :group, serializer: EventGroupSerializer
  attribute :creator

  def creator
    object.user.username
  end
  
end
