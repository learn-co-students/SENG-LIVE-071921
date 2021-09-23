class BookShowSerializer < ActiveModel::Serializer
  attributes :id, :title, :description

  has_many :readers
  has_many :users_who_want_to_read

end
