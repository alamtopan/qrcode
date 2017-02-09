role :app, %w{qrcode@104.251.212.107}
role :web, %w{qrcode@104.251.212.107}
role :db,  %w{qrcode@104.251.212.107}

set :stage, :production

# Replace 127.0.0.1 with your server's IP address!
server '104.251.212.107', user: 'qrcode', roles: %w{web app}

set :rbenv_type,     :system
set :rbenv_ruby,     '2.3.0'
set :rbenv_prefix,   "RBENV_ROOT=#{fetch(:rbenv_path)} RBENV_VERSION=#{fetch(:rbenv_ruby)} #{fetch(:rbenv_path)}/bin/rbenv exec"
set :rbenv_map_bins, %w{rake gem bundle ruby rails}
set :rbenv_roles,    :all

set :deploy_to,       "/home/qrcode/www"
set :rails_env,       "production"
set :branch,          "master"

set :unicorn_config_path, "/home/qrcode/www/current/config/unicorn.rb"