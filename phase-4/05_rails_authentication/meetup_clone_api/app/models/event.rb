class Event < ApplicationRecord
  belongs_to :user
  belongs_to :group
  has_many :user_events, dependent: :destroy
  has_many :attendees, through: :user_events, source: :user

  validates :title, :description, :location, :start_time, :end_time, presence: true

  validates :title, uniqueness: { scope: [:location, :start_time], message: "can't rsvp to the same event more than once"}

  def group_name=(group_name)
    self.group = Group.find_or_create_by(name: group_name)
  end
  
end
