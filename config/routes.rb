Rails.application.routes.draw do
  resources :order_details
  resources :orders
  resources :categories
  resources :products
  resources :users

  post "/login", to: "users#login"
  get "/autologin", to: "users#autologin"

  post "/cart", to: "orders#cart"
  patch "/submit", to: "orders#submit"

  post "/orders", to: "orders#order"

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
