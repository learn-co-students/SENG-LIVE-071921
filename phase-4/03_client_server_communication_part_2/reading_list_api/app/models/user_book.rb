class UserBook < ApplicationRecord
  belongs_to :user
  belongs_to :book
  validates :book_id, uniqueness: { scope: [:user_id], message: "This book is already on your bookshelf" }
end
