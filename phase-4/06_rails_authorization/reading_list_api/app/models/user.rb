class User < ApplicationRecord
  has_many :user_books
  has_many :books, through: :user_books

  validates :username, presence: true, uniqueness: true
  validates :email, uniqueness: true
  has_secure_password
end
