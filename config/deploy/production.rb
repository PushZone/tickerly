server '128.199.155.238', user: 'deploy', roles: %w{web app db}

set :ssh_options, { forward_agent: true }
set :application, 'tickerly-web' #change this to the name of your app
set :repo_url, 'git@github.com:abovelab/tickerly-web.git' #change this to the url of your app on github
set :deploy_to, '/home/deploy/tickerly-web'
set :use_sudo, true
set :branch, 'develop' #or whichever branch you want to use
set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system')