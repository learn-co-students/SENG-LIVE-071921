class DogWalk < ActiveRecord::Base
  belongs_to :dog
  belongs_to :walk
end