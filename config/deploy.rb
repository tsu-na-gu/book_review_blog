# config valid for current version and patch releases of Capistrano
set :application, 'book_reveiw_blog'
set :repo_url, 'https://github.com/tsu-na-gu/book_raview_blog.git'
set :branch, 'main'
append :linked_files, 'config/database.yml',
                                   'config/secrets.yml',
                                   'config/storage.yml'
append :linked_dirs, 'storage',
       'log',
       'tmp/pids',
       'tmp/cache',
       'tmp/sockets',
       'public/system'
set :passenger_restart_with_touch, true

namespace :deploy do
  desc 'Set environment variables'
  task :set_env_vars do
    on roles(:app), in: :sequence, wait: 10 do
      execute :echo, "'export DATABASE_USERNAME=admin' >> ~/.bashrc"
      execute :echo, "'export DATABASE_PASSWORD=password0123blue' >> ~/.bashrc"
      execute :echo, "'export BASE_URL=book.tsu-na-gu.site' >> ~/.bashrc"
    end
  end
end

before 'deploy:starting', 'deploy:set_env_vars'

# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name
# set :deploy_to, "/var/www/my_app_name"

# Default value for :format is :airbrussh.
# set :format, :airbrussh

# You can configure the Airbrussh format using :format_options.
# These are the defaults.
# set :format_options, command_output: true, log_file: "log/capistrano.log", color: :auto, truncate: :auto

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
# append :linked_files, "config/database.yml", 'config/master.key'

# Default value for linked_dirs is []
# append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets", "public/system", "vendor", "storage"

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for local_user is ENV['USER']
# set :local_user, -> { `git config user.name`.chomp }

# Default value for keep_releases is 5
# set :keep_releases, 5

# Uncomment the following to require manually verifying the host key before first deploy.
# set :ssh_options, verify_host_key: :secure
