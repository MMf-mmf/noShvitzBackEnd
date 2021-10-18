Rails.application.routes.draw do

  resources :order_details
  resources :orders
  resources :categories
  resources :products
  resources :users
  resources :account_activations, only: [:edit]
  resources :password_resets, only: [:new, :create, :edit, :update]

  
  patch 'account_activations', to: 'account_activations#edit'
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  get "/autologin", to: "sessions#autologin"
  get "/users", to: "users#index"
  get "/users/:id", to: "users#show"
  post "/users_bulk_create", to: "users#users_bulk_create"
  post "products_bulk_create", to: "products#products_bulk_create"
  post "categories_bulk_create", to:"categories#categories_bulk_create"
  post "charges", to: "charges#create"
  post "/cart", to: "orders#cart"
  post "/cartCount", to: "orders#cartCount"
  patch "/submit", to: "orders#submit"
  post "/orders", to: "orders#order"
  delete "delete_orders", to: "orders#delete"
  patch "/password_resets", to: "password_resets#update"
  get "what_to_order/:id", to: "order_details#what_to_order"
  delete "categories", to: "categories#delete"
  delete "products", to: "products#delete"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end






