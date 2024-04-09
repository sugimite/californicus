Rails.application.routes.draw do
  namespace :admin do
    root "top#index"
    get "login" => "sessions#new", as: :login
    resources :students, except: [ :show ] do
      resources :memos
      resources :grades, except: [ :show ]
    end
    resources :grades, only: [ :index ]
    resource :session, only: [ :create, :destroy ]
  end

  namespace :student, path: "" do
    root "top#index"
    get "login" => "sessions#new", as: :login
    resource :session, only: [ :create, :destroy ]
  end  
end
