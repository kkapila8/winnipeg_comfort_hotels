Rails.application.routes.draw do
  ActiveAdmin.routes(self)

  devise_for :users, controllers: {
    registrations: "users/registrations",
    sessions:      "users/sessions"
  }, sign_out_via: :get

  root "rooms#index"

  resources :rooms, only: [:index, :show]
  resources :categories, only: [:show]

  resource :cart, only: [:show] do
    post   :add_item
    patch  :update_item
    delete :remove_item
  end

  resource :checkout, only: [:show, :create]
  resources :orders, only: [:index, :show]

  get "/about",   to: "pages#about",   as: :about
  get "/contact", to: "pages#contact", as: :contact

  resource :profile, only: [:show, :edit, :update]
end