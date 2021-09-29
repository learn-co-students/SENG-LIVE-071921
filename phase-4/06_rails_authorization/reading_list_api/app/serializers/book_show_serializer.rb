class BookShowSerializer < BookIndexSerializer
  
  has_many :readers
  has_many :users_who_want_to_read

end
