class Event < ApplicationRecord
  belongs_to :user
  belongs_to :group
  has_many :user_events
  has_many :attendees, through: :user_events, source: :user
end
