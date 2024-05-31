Rails.application.routes.draw do
  namespace :admin do
    root "top#index"
    get "login" => "sessions#new", as: :login
    resources :students, except: [ :show ] do
      scope module: :students do
        resources :memos
        resources :homeworks, except: [ :show ]
        resources :grades, except: [ :show ]
        resources :attendances, except: [ :show ]
      end
      member do 
        patch "submit_homework"
        patch "leaving_seat"
        post "taking_seat"
      end
    end
    resources :homeworks, only: [ :index ]
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
