class LendingsController < ApplicationController
  before_action :set_lending, only: %i[new create edit update destroy]
  before_action :set_lending_form, only: %i[new create edit update]

  def index
    @lendings = Lending.all
  end

  def new
  end

  def create
    if @lending_form.save
      stream_redirect_to [ :lendings ]
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @lending_form.save
      stream_redirect_to [ :lendings ]
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @lending.destroy!
    redirect_to [ :lendings ]
  end

  private

  def set_lending
    if params[:id]
      @lending = Lending.find(params[:id])
      return
    end

    @lending = Lending.new
  end

  def set_lending_form
    @lending_form = if @lending.persisted?
                      LendingForm.from(@lending)
                    else
                      LendingForm.new
                    end

    if params[:lending_form]
      @lending_form.assign_attributes(params[:lending_form].permit!)
      LendingForm::OPS.each do |op, callable|
        callable.call(@lending_form, params[op]) if params[op]
      end
    end

    # Cookie persistence
    # cookie_name = Base64.encode64("lending_form_#{request.path}")
    # if params[:lending_form].present?
    #   cookies[cookie_name] = JSON.generate(params[:lending_form]&.as_json)
    # end

    # lending_form_params = cookies[cookie_name].present? ? JSON.parse(cookies[cookie_name]) : {}
    # @lending_form = LendingForm.new(**lending_form_params)
  end
end
