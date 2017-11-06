# frozen_string_literal: true
lock '3.9.1'

set :application, 'action cable chat'
set :repo_url, 'https://github.com/rnitta/actioncable-chat.git'

set :deploy_to, '/home/rnitta/acc/'

set :keep_releases, 5
set :ssh_options, port: '2222'

set :rbenv_type, :system
set :rbenv_ruby, '2.4.2'

set :rbenv_prefix,
      "RBENV_ROOT=#{fetch(:rbenv_path)} RBENV_VERSION=#{fetch(:rbenv_ruby)} #{fetch(:rbenv_path)}/bin/rbenv exec"
set :rbenv_map_bins, %w{rake gem bundle ruby rails}
set :rbenv_roles, :all # default value

set :linked_dirs, %w{bin log tmp/backup tmp/pids tmp/cache tmp/sockets vendor/bundle}
set :unicorn_pid, "#{shared_path}/tmp/pids/unicorn.pid"

set :bundle_jobs, 4

after 'deploy:publishing', 'deploy:restart'
namespace :deploy do
  task :restart do
    invoke 'unicorn:restart'
  end
end
# Default
