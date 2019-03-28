Rails.application.routes.draw do
    get 'answers/new'
    root "static_pages#home"
    get "/about", to: "static_pages#about"

    namespace :admins do
        resources :users, only: [:index, :update]
        resources :categories do
            resources :questions
        end
    end

    get "/signup", to: "users#new"

    get "login", to: "sessions#new"
    post "login", to: "sessions#create"
    delete "/logout", to: "sessions#destroy"

    get "feed", to: "users#feed"

    resources :users, except: :new do
      member do
        get :lesson
        get :relationship
      end
    end

    resources :relationships, only: [:create, :destroy]

    resources :categories do
        resources :questions
    end

    resources :lessons do 
        resources :answers
    end

end
