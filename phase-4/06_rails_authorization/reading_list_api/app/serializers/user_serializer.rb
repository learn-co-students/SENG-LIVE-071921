class UserSerializer < ActiveModel::Serializer
  attributes :id, :username, :bio, :email
end
