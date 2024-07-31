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
        resources :contacts, except: [ :show ] 
      end
      collection do
        get "assign_homeworks"
        post "create_homeworks"
      end
      member do 
        patch "submit_homework"
        patch "leaving_seat"
        patch "increase_number"
        patch "decrease_number"
        post "taking_seat"
      end
    end
    resources :homeworks, only: [ :index ]
    resources :grades, only: [ :index ]
    resources :attendances, only: [ :index ]
    resource :session, only: [ :create, :destroy ]
    resources :contacts, only: [ :index, :destroy ] do
      delete "destroy_all_by_student/:student_id", to: "contacts#destroy_all_by_student", as: "destroy_all_by_student", on: :collection
    end
  end

  namespace :student, path: "" do
    root "top#index"
    get "login" => "sessions#new", as: :login
    resource :session, only: [ :create, :destroy ]
    resources :contacts, only: [ :index, :new, :create, :destroy ]
  end  
end
