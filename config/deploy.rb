lock '3.5.0'

set :application, 'qrcode'
set :repo_url, 'git@github.com:alamtopan/qrcode.git'
set :scm, :git
set :deploy_to, '/home/qrcode/www'

set :format, :pretty
set :log_level, :info

set :linked_files, %w{config/database.yml}
set :linked_dirs, %w{bin log tmp vendor/bundle public/system public/uploads}

set :rbenv_path, '/home/qrcode/.rbenv'

set :default_env, {
   path: "/home/qrcode/.rbenv/shims:/home/qrcode/.rbenv/bin:$PATH"
 }

set :keep_releases, 3

namespace :deploy do

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      invoke 'unicorn:restart'
    end
  end

  after :finishing, 'deploy:cleanup'
end

after 'deploy:publishing', 'deploy:restart'

