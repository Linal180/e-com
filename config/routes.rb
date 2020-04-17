Rails.application.routes.draw do
  devise_for :users
  resources :items
  root 'pages#welcome'
  post 'add_order', to: 'orders#create'
end
