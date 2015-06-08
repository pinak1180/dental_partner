DentalPartner::Application.routes.draw do
  scope '/admin' do
    devise_for :users, controllers: { sessions: 'admins/sessions' }
  end
end
