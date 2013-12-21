# $:.unshift(File.expand_path('./lib', ENV['rvm_path']))
# RVM
require "rvm/capistrano"
set :rvm_ruby_string, 'default'
set :rvm_type, :user

# Bundler

require "bundler/capistrano"
require 'sidekiq/capistrano'
# General

set :application, "side"
set :user, "deployer"

set :deploy_to, "/home/#{user}/#{application}"
set :deploy_via, :copy

set :use_sudo, false

# Git

set :scm, :git
set :repository,  "git@github.com:labotsky/side.git"
set :branch, "master"

# VPS

role :web, "162.243.205.71"
role :app, "162.243.205.71"
role :db,  "162.243.205.71", :primary => true
role :db,  "162.243.205.71"

# Passenger

namespace :deploy do
 task :start do ; end
 task :stop do ; end
 task :restart, :roles => :app, :except => { :no_release => true } do
   run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
 end
end
after "deploy:restart", "deploy:cleanup"