class Event < ApplicationRecord
  belongs_to :group
  belongs_to :user
  has_many :user_events
  has_many :attendees, through: :user_events, source: :user
end
