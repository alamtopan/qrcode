root = "/home/qrcode/www/current"
working_directory root

pid               "#{root}/tmp/pids/unicorn.pid"
stderr_path       "#{root}/log/unicorn_error.log"
stdout_path       "#{root}/log/unicorn.log"
listen            "#{root}/tmp/sockets/unicorn.sock"
worker_processes  5
timeout           120
preload_app       true

before_fork do |server, worker|

  # if defined?(Sidekiq)
  #   # @sidekiq_pid ||= spawn("bundle exec sidekiq -C config/sidekiq.yml")

  #   # Sidekiq.configure_server do |config|
  #   #   config.redis = { :url => ENV['REDISTOGO_URL'], :namespace => ENV['REDISTOGO_NAMESPACE'], :size => 5 }
  #   # end
  #   # Sidekiq.configure_client do |config|
  #   #   config.redis = { :url => ENV['REDISTOGO_URL'], :namespace => ENV['REDISTOGO_NAMESPACE'], :size => 1 }
  #   # end

  #   Signal.trap 'TERM' do
  #     puts 'Unicorn master intercepting TERM and sending myself QUIT instead'
  #     Process.kill 'QUIT', Process.pid
  #   end
  # end

  # If you are using Redis but not Resque, change this
  if defined?(Resque)
    Resque.redis.quit
    Rails.logger.info('Disconnected from Redis')
  end

  defined?(ActiveRecord::Base) and
    ActiveRecord::Base.connection.disconnect!
end

after_fork do |server, worker|
  Signal.trap 'TERM' do
    puts 'Unicorn worker intercepting TERM and doing nothing. Wait for master to sent QUIT'
  end

  # If you are using Redis but not Resque, change this
  if defined?(Resque)
    Resque.redis = ENV['REDISTOGO_URL']
    Rails.logger.info('Connected to Redis')
  end

  defined?(ActiveRecord::Base) and
    ActiveRecord::Base.establish_connection
end

