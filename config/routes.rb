Rails.application.routes.draw do
  resources :article_categories
  resources :categories
  #devise_for :users
  	 resources :users
     resources :articles
     # devise_for :sessions
     resources :sessions
     resources :users 
     root :to => 'sessions#show'

     get 'signup', to: 'users#new'
     post 'users', to: 'users#create '
      
     get 'login', to: 'sessions#new'
     post 'login', to: 'sessions#create'
     delete 'logout', to: 'sessions#destroy'

     #get 'user_conf/:confirmation_token/:email', to: "users#confirm_email"
     match 'user_conf/:confirmation_token/:email' => "users#confirm_email",
       :constraints => { :email => /.+@.+\..*/ } , via: [:get]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
