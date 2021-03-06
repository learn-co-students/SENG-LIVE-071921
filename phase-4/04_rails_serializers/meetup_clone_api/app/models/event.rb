class Event < ApplicationRecord
  belongs_to :user
  belongs_to :group
  has_many :user_events
  has_many :attendees, through: :user_events, source: :user

  validates :title, :description, :location, :start_time, :end_time, presence: true

  validates :title, uniqueness: { scope: [:location, :start_time], message: "Whoops! Did you already create this event?"}
end
