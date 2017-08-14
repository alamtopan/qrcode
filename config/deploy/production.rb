role :app, %w{course@63.142.253.124}
role :web, %w{course@63.142.253.124}
role :db,  %w{course@63.142.253.124}

set :stage, :production

# Replace 127.0.0.1 with your server's IP address!
server '63.142.253.124', user: 'course', roles: %w{web app}

set :rbenv_type,     :system
set :rbenv_ruby,     '2.3.0'
set :rbenv_prefix,   "RBENV_ROOT=#{fetch(:rbenv_path)} RBENV_VERSION=#{fetch(:rbenv_ruby)} #{fetch(:rbenv_path)}/bin/rbenv exec"
set :rbenv_map_bins, %w{rake gem bundle ruby rails}
set :rbenv_roles,    :all

set :deploy_to,       "/home/qrcode/www"
set :rails_env,       "production"
set :branch,          "course"

set :unicorn_config_path, "/home/course/www/current/config/unicorn.rb"