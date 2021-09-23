class BooksController < ApplicationController
  def index
    render json: Book.all, each_serializer: BookIndexSerializer
  end

  def show
    render json: Book.find(params[:id]), serializer: BookShowSerializer
  end

  def create
    book = current_user.books.build(book_params)
    if book.save
      render json: book, status: :created
    else
      render json: book.errors, status: :unprocessable_entity
    end
  end

  private

  def book_params
    params.permit(:title, :description, :author, :cover_image_url)
  end
end
