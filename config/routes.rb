Rails.application.routes.draw do
    root 'pages#home'
  get '/home', to: 'pages#home'
  
  resources :recipes, only: [:index, :show, :new, :create, :edit, :update]
end
