Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "static_pages#home"
  
  get "password_resets/new"
  get "password_resets/edit"
  get "/help", to: "static_pages#help"
  get "/about", to: "static_pages#about"
  get "/contact", to: "static_pages#contact"
  get "/signup", to: "users#new"
  post "/signup", to: "users#create"
  get "/notfound", to: "static_pages#notfound"
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"
  resources :users do
    member do
      get :following, :followers
    end
  end
  resources :account_activations, only: :edit
  resources :password_resets
  resources :microposts, only: [:create, :destroy]
  resources :relationships, only: [:create, :destroy]
end
