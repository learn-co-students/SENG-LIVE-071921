class User < ApplicationRecord
  has_many :created_events, class_name: 'Event'
  has_many :user_events
  has_many :events, through: :user_events
  has_many :user_groups
  has_many :groups, through: :user_groups
end
