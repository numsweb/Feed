set :runner, 'jkropka'
#set :admin_runner, 'jkropka' # user that makes the directories during deploy:setup
set :user, "jkropka"
set :remote, user

set :keep_releases, 3
set :use_sudo, false


set :ssh_options, { 
 # :port => 40295, 
  :keys => ["#{ENV['HOME']}/.ssh/id_dsa"], 
  :host_key => 'ssh-dss',
  :paranoid => false
}

#ssh_options[:keys] = ["#{ENV['HOME']}/.ssh/id_dsa"]

set :chmod755, "app config db lib public vendor script script/* public/disp*"



#set :user, 'jkropka'  # Your dreamhost account's username
set :domain, 'oneoriginalgeek.com'  # Dreamhost servername where your account is located 
set :project, 'feed'  # Your application as its called in the repository
set :application, 'feed.oneoriginalgeek.com'  # Your app's location (domain or sub-domain name as setup in panel)
set :applicationdir, "/home/#{user}/#{application}"  # The standard Dreamhost setup

# roles (servers)
role :web, domain
role :app, domain
role :db,  domain, :primary => true

# deploy config
set :deploy_to, applicationdir
set :deploy_via, :export

set  :stage, :staging

###
# Custom Tasks
###

before "deploy:setup", "bork_perms"
after "deploy:setup", "unbork_perms"

before "deploy:update", "bork_perms"
after "deploy:update", "unbork_perms"

before "deploy:migrate", "fix_perms"
before "deploy:migrate", "custom_symlinks"

after "deploy", "custom_symlinks"
after "deploy", "deploy:cleanup"

desc "Bork Permissions"
task :bork_perms do
   "chmod 777 #{deploy_to}"
   "chmod 777 #{releases_path}" rescue nil
   "chmod 777 #{shared_path}" rescue nil
   "chmod -R 777 #{shared_path}/cached-copy" rescue nil
end

desc "Unbork Permissions"
task :unbork_perms do
   "chmod 775 #{deploy_to}"
  "chmod 775 #{releases_path}"
  "chmod 775 #{shared_path}"
end

desc "Fix Permissions"
task :fix_perms do
   "chmod 777 #{current_path}/log"
   "chmod 666 #{shared_path}/log/*" rescue nil
  # is this right? or needed? we ARE running the deploy as jkropka...
     "chown -R  jkropka pg1767984 #{current_path}/*"
     "chown -R  jkropka pg1767984 #{shared_path}/cached-copy"
end

desc "Custom Symlinks"
task :custom_symlinks do
  #run "cp -Rf #{shared_path}/config/*.yml #{release_path}/config"  
  #run "ln -nfs #{shared_path}/blog_photos #{current_path}/public/blog_photos"
  #run "ln -nfs #{shared_path}/photos #{current_path}/public/photos"
end

namespace :deploy do
  desc "Load the default dataset"
  task :load_dataset do
    run "rake db:dataset:load"
  end
end

