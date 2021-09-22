class UserBooksController < ApplicationController
  def create
    user_book = current_user.user_books.build(user_book_params)
    if user_book.save
      render json: user_book, status: :created
    else 
      render json: user_book.errors, status: :unprocessable_entity
    end
  end

  private

  def user_book_params
    params.permit(:book_id)
  end
end
