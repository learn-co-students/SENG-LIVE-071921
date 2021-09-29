class GroupSerializer < GroupIndexSerializer
  has_many :events
  has_many :members
end
