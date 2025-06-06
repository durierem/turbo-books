Rails.application.routes.draw do
  root "books#index"

  resource :canvas, only: :destroy
  resources :help, only: %i[show destroy], param: :page

  resources :authors do
    get :on_books_change, on: :member
    get :on_books_change, on: :collection
  end
  resources :books
end
