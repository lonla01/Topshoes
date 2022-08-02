Rails.application.routes.draw do
  devise_for :users
  resources :articles
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root 'articles#index'

  get '/index.html', to: 'articles#index'
  get '/products.html', to: 'articles#index'
  get '/about.html', to: 'static#about'
  get '/contact.html', to: 'static#contact'
end
