class BooksController < ApplicationController
  def index
    @books = Book.includes(:author).all
  end

  def new
    @book = Book.new
    @authors = Author.all
    render :new, layout: "canvas"
  end

  def create
    @book = Book.new(book_params)
    @book.save!
    redirect_to [ :books ]
  end

  def edit
    @book = Book.find(params[:id])
    @authors = Author.all
  end

  def update
    @book = Book.find(params[:id])
    @book.update!(book_params)
    redirect_to [ :books ]
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy!
  end

  private

  def book_params
    params.require(:book).permit(:name, :author_id)
  end
end
