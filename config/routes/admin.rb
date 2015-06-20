DentalPartner::Application.routes.draw do
  scope '/admin' do
    devise_for :users, controllers: { sessions: 'admins/sessions' }, path_names: { sign_in: 'login', sign_out: 'logout' }, skip: [:registrations]
    devise_scope :user do
      get 'edit' => 'devise/registrations#edit', :as => 'edit_user_registration'
      put 'users' => 'devise/registrations#update', :as => 'user_registration'
    end
  end
  namespace :admins do
    resources :dashboard
    resources :users do
      collection do
        post :update_password
      end
    end
    resources :news
    resources :forums
    resources :surveys
    resources :messages do
      collection do
        post :reply
      end
    end
  end
end
