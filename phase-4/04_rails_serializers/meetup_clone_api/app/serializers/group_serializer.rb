class GroupSerializer < ActiveModel::Serializer
  attributes :id, :name, :location
  has_many :events
  has_many :members
end
