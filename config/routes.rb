Rails.application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'
  root 'admins/dashboard#index'
  load Rails.root.join 'config/routes/api.rb'
  load Rails.root.join 'config/routes/admin.rb'
  get "api_help/index"
end
