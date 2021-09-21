class Book < ApplicationRecord
  has_many :user_books
  has_many :readers, through: :user_books, source: :user
end
