Rails.application.routes.draw do
  root "books#index"

  resource :canvas, only: :destroy
  resources :help, only: %i[show destroy], param: :page

  resources :authors
  resources :books
end
