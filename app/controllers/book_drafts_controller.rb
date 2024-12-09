class BookDraftsController < ApplicationController
  def new
    @book_draft = Book::Draft.new
    render :new, layout: "canvas"
  end

  def create
    @book_draft = Book::Draft.new(book_draft_params)

    if @book_draft.save(context: :step_1)
      redirect_to [ :edit, @book_draft, step: 2 ]
    else
      render :new, layout: "canvas"
    end
  end

  def edit
    @book_draft = Book::Draft.find(params[:id])
    render :edit, layout: "canvas"
  end

  def update
    @book_draft = Book::Draft.find(params[:id])

    @book_draft.update!(book_draft_params)

    if @book_draft.completed?
      @book_draft.book.save!
      redirect_to [ :books ] and return
    else
      redirect_to [ :edit, @book_draft, step: @book_draft.next_step ] and return
    end

    render :edit, layout: "canvas"
  end

  private

  def book_draft_params
    params.require(:book_draft).permit(:step, :name, :shelf_id, :author_id)
  end
end
