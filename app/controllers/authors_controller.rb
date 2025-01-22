class AuthorsController < ApplicationController
  def index
    @authors = Author.all
  end

  def edit
    @author = Author.find(params[:id])
  end

  def new
    @author = Author.new
  end

  def create
    @author = Author.new(author_params)
    if @author.save
      respond_to do |format|
        format.html { redirect_to [ :edit, @author ], notice: "Author created!" }
        format.turbo_stream
      end
    else
      flash.now[:alert] = "Failed to create author!"
      render :new, status: :unprocessable_entity
    end
  end

  def update
    @author = Author.find(params[:id])
    if @author.update(author_params)
      redirect_to [ :edit, @author ], notice: "Author updated!"
    else
      flash.now[:alert] = "Failed to update author!"
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @author = Author.find(params[:id])
    @author.destroy
    redirect_to [ :authors ]
  end

  private

  def author_params
    params.require(:author).permit(:name)
  end
end
