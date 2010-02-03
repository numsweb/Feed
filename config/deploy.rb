set :application, "feed"
require 'capistrano/ext/multistage'


set :stages, %w(staging testing production)
set :default_stage, 'staging'
set :keep_releases,       5

#switch to git repo
set :scm, :git
set :scm_verbose, true # ubuntu's git doesn't support git reset -q
set :branch, 'master'
set :ssh_options, {:forward_agent => true}
set :repository, "git@github.com:numsweb/Feed.git"