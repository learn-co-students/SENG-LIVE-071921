class UserEvent < ApplicationRecord
  belongs_to :user
  belongs_to :event

  validates :event_id, uniqueness: { scope: [:user_id], message: "can't rsvp to the same event twice" }
end
