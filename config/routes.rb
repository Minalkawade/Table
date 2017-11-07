Rails.application.routes.draw do
  #devise_for :users
  	 resources :users
     resources :articles
     # devise_for :sessions

     root :to => 'sessions#show'

     get 'signup', to: 'users#new'
     post 'users', to: 'users#create '
      
     get 'login', to: 'sessions#new'
     post 'login', to: 'sessions#create'
     delete 'logout', to: 'sessions#destroy'

     get '/:token(confirm_email)/', to: "users#confirm_email", as: 'confirm_email'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
