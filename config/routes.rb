Rails.application.routes.draw do
  namespace :admin do
    root "top#index"
  end

  namespace :customer do
    root "top#index"
  end
  
end
