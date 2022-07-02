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

  get "donations/:id/edit", as: "edit_donation", to: "donations#edit"
  get "donations/new", as: "new_donation", to: "donations#new"
  get "donations/:id", as: "donation", to: "donations#show"
  get "donations", as: "donations", to: "donations#index"
  post "donations", as: "", to: "donations#create"
  patch "donations/:id", as: "", to: "donations#update"
  put "donations/:id", as: "", to: "donations#update"
  delete "donations/:id", as: "", to: "donations#destroy"
end
