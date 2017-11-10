# frozen_string_literal: true
lock '3.9.1'

set :application, 'action_cable_chat'
set :repo_url, 'https://github.com/rnitta/actioncable-chat.git'

set :deploy_to, '/home/rnitta/acc/'

set :keep_releases, 5
set :ssh_options, port: '2222'

set :rbenv_type, :user
set :rbenv_ruby, '2.4.2'
set :rbenv_path, '/home/rnitta/.rbenv'

set :rbenv_prefix,
      "RBENV_ROOT=#{fetch(:rbenv_path)} RBENV_VERSION=#{fetch(:rbenv_ruby)} #{fetch(:rbenv_path)}/bin/rbenv exec"
set :rbenv_map_bins, %w{rake gem bundle ruby rails}
set :rbenv_roles, :all # default value

set :linked_dirs, %w{bin log tmp/backup tmp/pids tmp/cache tmp/sockets vendor/bundle}

set :bundle_jobs, 4
set :rails_env, 'production'

set :unicorn_pid, -> { "/tmp/unicorn.pid" }
set :unicorn_config_path, 'config/unicorn.rb'
set :unicorn_rack_env, 'deployment' # "development", "deployment", or "none"

namespace :deploy do
  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      invoke 'unicorn:restart'
    end
  end

  after :publishing, :restart

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
    end
  end

end
