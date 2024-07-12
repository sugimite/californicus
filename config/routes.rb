Rails.application.routes.draw do
  namespace :admin do
    root "top#index"
    get "login" => "sessions#new", as: :login
    resources :students, except: [ :show ] do
      scope module: :students do
        resources :memos
        resources :grades, except: [ :show ]
        resources :attendances, except: [ :show ]
      end
      member do 
        patch "leaving_seat"
        post "taking_seat"
      end
    end
    resources :grades, only: [ :index ]
    resources :attendances, only: [ :index ]
    resource :session, only: [ :create, :destroy ]
    resources :contacts do
      collection do
        get "inbound"
        get "outbound"
      end
    end
    get "contacts/count" => "ajax#contact_count"
  end

  namespace :student, path: "" do
    root "top#index"
    get "login" => "sessions#new", as: :login
    resource :session, only: [ :create, :destroy ]
    resources :contacts, only: [ :new, :create ] do
      post :confirm, on: :collection
    end
  end  
end
