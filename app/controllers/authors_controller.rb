class AuthorsController < ApplicationController
  def index
    @authors = Author.all
  end

  def edit
    @author = Author.find(params[:id])
    @selected_books = @author.books
    @books = Book.all
  end

  def new
    @author = Author.new
    @selected_books = Book.none
    @books = Book.all
  end

  def create
    @author = Author.new(author_params)
    if @author.save
      redirect_to [ :edit, @author ], notice: "Author created!"
    else
      @books = Book.all
      @selected_books = Book.none
      flash.now[:alert] = "Failed to create author!"
      render :new, status: :unprocessable_entity
    end
  end

  def update
    @author = Author.find(params[:id])
    if @author.update(author_params)
      redirect_to [ :edit, @author ], notice: "Author updated!"
    else
      @selected_books = @author.books
      @books = Book.all
      flash.now[:alert] = "Failed to update author!"
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @author = Author.find(params[:id])
    @author.destroy
    redirect_to [ :authors ]
  end

  def on_books_change
    author = Author.find_by(params[:id]) || Author.new
    selected_books = Book.where(id: author_params[:book_ids])
    books = Book.by_name(params[:q])
    render partial: "form", locals: { author:, books:, selected_books: }
  end

  private

  def author_params
    params.require(:author).permit(:name, book_ids: [])
  end
end
