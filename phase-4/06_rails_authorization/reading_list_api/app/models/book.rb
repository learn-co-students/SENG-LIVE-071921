class Book < ApplicationRecord
  has_many :user_books, dependent: :destroy
  has_many :readers, -> { where(user_books: {read: true})}, through: :user_books, source: :user
  has_many :users_who_want_to_read, -> { where(user_books: {read: [false, nil]})}, through: :user_books, source: :user
  

  validates :title, :author, :description, presence: true
  validates :title, uniqueness: { scope: [:author] }
end
