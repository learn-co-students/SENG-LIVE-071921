class UserBooksController < ApplicationController
  def create
    user_book = current_user.user_books.build(user_book_params)
    if user_book.save
      render json: user_book, status: :created
    else 
      render json: user_book.errors, status: :unprocessable_entity
    end
  end

  def update
    user_book = UserBook.find(params[:id])
    if user_book.update(read: user_book_params[:read])
      render json: user_book, status: :ok
    else
      render json: user_book.errors, status: :unprocessable_entity
    end
  end

  def destroy
    user_book = UserBook.find(params[:id])
    user_book.destroy
    # render the user_book so we can enable undo functionality on the frontend if we want
    render json: user_book, status: :ok 
  end

  private

  def user_book_params
    params.permit(:book_id, :read)
  end
end
