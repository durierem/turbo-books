class BookDraftsController < ApplicationController
  def new
    @book_draft = Book::Draft.new
    render :new, layout: "canvas"
  end

  def create
    @book_draft = Book::Draft.new(book_draft_params)

    if @book_draft.save(context: :step_1)
      redirect_to [ :edit, @book_draft ]
    else
      render :new, layout: "canvas", status: :unprocessable_entity
    end
  end

  def edit
    @book_draft = Book::Draft.find(params[:id])
    render :edit, layout: "canvas"
  end

  def update
    @book_draft = Book::Draft.find(params[:id])

    @book_draft.attributes = book_draft_params
    if @book_draft.save(context: :"step_#{@book_draft.step}")
      if @book_draft.completed?
        @book_draft.book.save!
        redirect_to_out_of_frame([ :books ])
      else
        redirect_to [ :edit, @book_draft ]
      end
    else
      render :edit, layout: "canvas", status: :unprocessable_entity
    end
  end

  private

  def book_draft_params
    params.require(:book_draft).permit(:step, :name, :shelf_id, :author_id)
  end
end
