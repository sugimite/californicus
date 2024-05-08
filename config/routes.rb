Rails.application.routes.draw do
  namespace :admin do
    root "top#index"
    get "login" => "sessions#new", as: :login
    resources :students, except: [ :show ] do
      resources :memos
      resources :grades, except: [ :show ]
      resources :attendances, except: [ :show ]
      member do 
        get "leaving_seat"
        get "taking_seat"
      end
    end
    resources :grades, only: [ :index ]
    resources :attendances, only: [ :index ]
    resource :session, only: [ :create, :destroy ]
  end

  namespace :student, path: "" do
    root "top#index"
    get "login" => "sessions#new", as: :login
    resource :session, only: [ :create, :destroy ]
  end  
end
