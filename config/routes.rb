Rails.application.routes.draw do
  

  devise_for :users
  # if .admin == true
  #   root "items#index"
  # end
  
  resources :items
  delete 'destroy_item', to: 'items#destroy', as: 'destroy_item'

  resources :orders
  root 'pages#dashboard'
  get "welcome", to: "pages#welcome"
  get 'admin', to: "pages#admin"
  post 'add_order', to: 'orders#create'
  delete "remove_order", to: "orders#destroy"
  post "add_like", to: "likes#create"
  delete "remove_like", to: "likes#destroy"
  get "favorites", to: "likes#index"
  get "search_item", to: "items#search"
  get "all_items", to: 'pages#all_items'
  get "all_users", to: 'pages#all_users'
  post "make_admin", to: "pages#make_admin"
  delete "delete_user", to: "pages#delete_user"
  post "undo_admin", to: "pages#undo_admin"
  get "all_orders", to: "pages#all_orders"
  get '*a' => "items#index",
  :constraints => { :not_found => /.*/ }
end
