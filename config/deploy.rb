require 'mina/bundler'
require 'mina/rails'
require 'mina/git'
require 'mina/rvm'
require 'mina_sidekiq/tasks'
# require 'mina/rbenv'  # for rbenv support. (http://rbenv.org)
# require 'mina/rvm'    # for rvm support. (http://rvm.io)

set :domain, '139.162.24.20'
set :user,    'admin'
set :application, 'dental_partner'
set :repository, 'git@github.com:pinak1180/dental_partner.git'
set :branch, 'master'
set :deploy_to, '/var/www/application/dental_partner'
set :rvm_path, '/usr/local/rvm/scripts/rvm'
set :rails_env, 'production'
set :port, '22 -A'
# Manually create these paths in shared/ (eg: shared/config/database.yml) in your server.
# They will be linked in the 'deploy:link_shared_paths' step.
set :shared_paths, ['config/database.yml', 'log','config/application.yml', 'public/system', 'public/tmp', 'config/application.yml']

task :environment do
  # If you're using rbenv, use this to load the rbenv environment.
  # Be sure to commit your .rbenv-version to your repository.
  # invoke :'rbenv:load'

  # For those using RVM, use this to load an RVM version@gemset.
  invoke :'rvm:use[ruby-2.2.2@dental_partner]'
end

# Put any custom mkdir's in here for when `mina setup` is ran.
# For Rails apps, we'll make some of the shared paths that are shared between
# all releases.
task setup: :environment do
  queue! %(mkdir -p "#{deploy_to}/shared/log")
  queue! %(chmod g+rx,u+rwx "#{deploy_to}/shared/log")

  queue! %(mkdir -p "#{deploy_to}/shared/pids/")

  queue! %(mkdir -p "#{deploy_to}/shared/config")
  queue! %(chmod g+rx,u+rwx "#{deploy_to}/shared/config")

  queue! %(touch "#{deploy_to}/shared/config/database.yml")
  queue %(echo "-----> Be sure to edit 'shared/config/database.yml'.")

  queue! %(touch "#{deploy_to}/shared/config/application.yml")
  queue %(echo "-----> Be sure to edit 'shared/config/application.yml'.")


  queue! %(mkdir -p "#{deploy_to}/shared/public/system")
  queue! %(chmod g+rx,u+rwx "#{deploy_to}/shared/public/system")

  queue! %(mkdir -p "#{deploy_to}/shared/public/tmp")
  queue! %(chmod g+rx,u+rwx "#{deploy_to}/shared/public/tmp")
end

desc 'Deploys the current version to the server.'
task deploy: :environment do
  deploy do
    # Put things that will set up an empty directory into a fully set-up
    # instance of your project.
    invoke :'sidekiq:quiet'
    invoke :'git:clone'
    invoke :'deploy:link_shared_paths'
    invoke :'bundle:install'
    invoke :'rails:db_migrate'
    invoke :'rails:assets_precompile'
    to :launch do
      invoke :'sidekiq:restart'
      queue "mkdir -p #{deploy_to}/#{current_path}/tmp/"
      queue "touch #{deploy_to}/#{current_path}/tmp/restart.txt"
      #invoke :'unicorn_restart'
    end
  end
end

task :unicorn_restart do
  queue %(echo `ps -ef | grep "unicorn" | grep -v "color" | awk '{print $2}'`)
  queue %(sudo kill -9 `echo `ps -ef | grep "unicorn" | grep -v "color" | awk '{print $2}'``)
  queue "RAILS_ENV=production bundle exec unicorn -p 5000 -l 139.162.24.20:6000 -D"
end

desc "Shows logs."
task :logs do
  queue %[cd #{deploy_to}/current && tail -f log/production.log]
end
