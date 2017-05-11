# -*- encoding : utf-8 -*-
require 'capistrano-rbenv'
load 'deploy/assets'
SSH_USER = 'root'
ssh_options[:port] = 35888
set :rake, "bundle exec rake"
set :application, "duxiao_blog"
set :repository, "."
set :scm, :none
set :deploy_via, :copy
server = "dxblog.siwei.tech"

role :web, server
role :app, server
role :db,  server, :primary => true
role :db,  server

set :deploy_to, "/opt/blogs/duxiao_blog"
default_run_options[:pty] = true

# change to your username
set :user, SSH_USER

namespace :deploy do
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "nginx -s reload"
  end

  namespace :assets do
    task :precompile do
      puts "== 这个命令没有用，但是rails中每次都会执行，所以使用空语句覆盖它。"
      #run "bundle install"
      #run "cd #{release_path} && bundle exec rake RAILS_ENV=production RAILS_GROUPS=assets assets:precompile "
    end
    task :symlink do
      puts "== 这个命令没有用，但是rails中每次都会执行，所以使用空语句覆盖它。"
    end
  end
end

#after "deploy", "deploy:restart"
