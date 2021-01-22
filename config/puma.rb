# workers ENV.fetch("WEB_CONCURRENCY") { 2 }
# preload_app!

max_threads_count = ENV.fetch('RAILS_MAX_THREADS') { 5 }
min_threads_count = ENV.fetch('RAILS_MIN_THREADS') { max_threads_count }
threads min_threads_count, max_threads_count

rails_env = ENV.fetch('RAILS_ENV') { 'development' }

port        ENV.fetch('PORT') { 3000 }
environment rails_env
pidfile     ENV.fetch('PIDFILE') { 'tmp/pids/server.pid' }

plugin :tmp_restart

if rails_env == 'production' || rails_env == 'staging'
  app_dir = File.expand_path('../..', __FILE__)
  shared_dir = "#{app_dir}/shared/tmp"

  bind "unix://#{shared_dir}/sockets/puma.sock"
  stdout_redirect "#{shared_dir}/log/puma.stdout.log", "#{shared_dir}/log/puma.stderr.log", true
  pidfile "#{shared_dir}/pids/puma.pid"
  state_path "#{shared_dir}/sockets/puma.state"
  activate_control_app
end
