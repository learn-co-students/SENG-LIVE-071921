class BookIndexSerializer < ActiveModel::Serializer
  attributes :id, :title, :author, :description
end
