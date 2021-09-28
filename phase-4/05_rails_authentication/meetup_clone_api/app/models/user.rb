class User < ApplicationRecord
  has_many :user_groups
  has_many :groups, through: :user_groups
  has_many :user_events
  has_many :events, through: :user_events
  has_many :created_events, class_name: 'Event'

  validates :email, uniqueness: true, allow_blank: true
  validates :username, presence: true, uniqueness: true
  has_secure_password
  # defines a password= method that will take a string and run it through BCrypt to create the value that will live in the password_digest column
  # defines a password_confirmation= method that will check if the confirmation matches the original
  # defines an authenticate method that will check if a user's password encrypts to the same value as the stored value.
end
