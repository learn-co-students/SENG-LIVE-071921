class User < ApplicationRecord
  has_many :user_books
  has_many :books, through: :user_books
end
