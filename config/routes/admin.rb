DentalPartner::Application.routes.draw do
  scope '/admin' do
    devise_for :users, controllers: { sessions: 'admins/sessions' }, path_names: { sign_in: 'login', sign_out: 'logout' }, skip: [:registrations]
  end
  namespace :admins do
    resources :dashboard
    resources :users
    resources :news
    resources :forums
    resources :surveys
  end
end
