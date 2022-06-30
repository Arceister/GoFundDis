Rails.application.routes.draw do
  get "profile", as: "edit_user", to: "users#edit"
  resources :users, :except => :edit
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root "main#index"

  get "login", to: "sessions#new"
  post "login", to: "sessions#create"

  delete "logout", to: "sessions#destroy"

  get "donations/:id", as: "donation", to: "donations#show"
end
