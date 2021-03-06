DentalPartner::Application.routes.draw do
  namespace :api, defaults: { format: 'json' } do
    scope module: :v1 do
      namespace :dental_partner do
        post 'login'           => 'sessions#create',           as: :login
        get  'logout'          => 'sessions#destroy',          as: :logout
        post 'forgot_password' => 'passwords#create',          as: :forgot_password
        post 'change_password' => 'passwords#change_password', as: :change_password
        post "mark_read"       => 'messages#mark_read',        as: :mark_read
        resources :users, only: [ :index ]
        resources :news, only: [:index,:show]
        namespace :news do
          resources :comments, only: [:create]
          resources :likes, only: [:create,:destroy]
        end
        resources :forums, only: [:index,:show]
        namespace :forums do
          resources :comments, only: [:create]
          resources :follows, only: [:create,:destroy]
        end
        resources :surveys, only: [:index,:show] do
          resources :responses, only: [:create]
        end
        resources :messages, only: [:index, :show, :create, :destroy]
      end
    end
  end
end
