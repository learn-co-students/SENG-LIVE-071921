class BooksController < ApplicationController
  before_action :confirm_authentication
  before_action :set_book, only: [:show, :update, :destroy]
  before_action :authorize_user, only: [:update, :destroy]

  def index
    render json: Book.all, each_serializer: BookIndexSerializer
  end

  def show
    render json: @book, serializer: BookShowSerializer
  end

  def create
    book = current_user.books.build(book_params)
    if book.save
      render json: book, status: :created
    else
      render json: book.errors, status: :unprocessable_entity
    end
  end

  def update
    if @book.update(book_params)
      render json: @book, status: :ok, serializer: BookShowSerializer
    else
      render json: book.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @book.destroy
    head :no_content
  end

  private

  def book_params
    params.permit(:title, :description, :author, :cover_image_url)
  end

  def set_book
    @book = Book.find(params[:id])
  end

  def authorize_user
    return render json: { error: "You are not authorized to perform this action" }, status: :forbidden unless current_user.admin?
  end
end
