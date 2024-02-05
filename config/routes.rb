Rails.application.routes.draw do
  namespace :admin do
    root "top#index"
    get "login" => "sessions#new", as: :login
    resources :students, except: [ :show ]
    resource :session, only: [ :create, :destroy ]
  end

  namespace :student, path: "" do
    root "top#index"
    get "login" => "session#new", as: :login
  end  
end
