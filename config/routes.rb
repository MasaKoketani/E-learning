Rails.application.routes.draw do
    root "static_pages#home"
    get "/about", to: "static_pages#about"

    namespace :admins do
        resources :users, only: [:index, :update]
        resources :categories
    end

    get "/signup", to: "users#new"

    get "login", to: "sessions#new"
    post "login", to: "sessions#create"
    delete "/logout", to: "sessions#destroy"

    get "feed", to: "users#feed"

    resources :users, except: :new
    resources :relationships, only: [:create, :destroy]
    resources :categories, only: [:index]
end
