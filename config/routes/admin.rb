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
        post :import
        get  :notifications
        post :notification_badge
      end
    end
    resources :news do
      collection do
        post '/:id/comments/:c_id' => 'news#mark_not_allowed', as: :mark_not_allowed
      end
    end
    resources :forums do
      collection do
        post '/:id/comments/:c_id' => 'forums#mark_not_allowed', as: :mark_not_allowed
      end
    end
    resources :comments, only: [:create]
    resources :surveys
    resources :practise_codes, except: [:destroy, :show]
    resources :direct_reports, except: [:destroy, :show]
    resources :messages do
      collection do
        post :reply
      end
    end
    resources :documents, only: [:new, :index, :create]
    resources :contacts do
      collection do
        post :import
      end
    end
    resources :reports
  end
end
