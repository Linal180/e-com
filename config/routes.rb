Rails.application.routes.draw do
  devise_for :users
  resources :items
  resources :orders
  root 'pages#welcome'
  post 'add_order', to: 'orders#create'
  delete "remove_order", to: "orders#destroy"
  post "add_like", to: "likes#create"
  delete "remove_like", to: "likes#destroy"
end
