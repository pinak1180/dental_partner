Rails.application.routes.draw do
  load Rails.root.join 'config/routes/api.rb'
  load Rails.root.join 'config/routes/admin.rb'
  get "api_help/index"
end
