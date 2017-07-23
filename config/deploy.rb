# config valid only for current version of Capistrano
lock "3.8.2"

set :deploy_to, '/home/deploy/tickerly-web'
set :repo_url, "git@github.com:PushZone/tickerly.git"

set :ssh_options, { forward_agent: true }
set :application, 'tickerly-web' #change this to the name of your app
set :deploy_to, '/home/deploy/tickerly-web'
set :use_sudo, true
set :branch, 'develop' #or whichever branch you want to use
set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system')


append :linked_files, "config/database.yml", "config/secrets.yml"


namespace :deploy do
  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      execute :touch, release_path.join('tmp/restart.txt')
    end
  end
end
