require "mt-capistrano"

set :site,         "81961"
set :application,  "x5"
set :webpath,      "timex5.com"
set :domain,       "timex5.com"
set :user,         "timex5.com"
set :password,     "x5er135%_"

set :use_sudo,     false

# repository 
set :scm, :git
set :repository, "git@dearstudio.com:/home/git/repositories/x5er-code.git"
set :scm_password, "captain11"
set :deploy_to,    "/home/#{site}/containers/rails/#{application}"
set :current_deploy_dir, "#{deploy_to}/current"
set :deploy_via, :remote_cache
set :tmp_dir, "#{deploy_to}/tmp"
set :branch, "master"
set :git_enable_submodules, 1

# Less releases, less space wasted
set :keep_releases, 5

set :checkout, "export"

# which environment to work in
set :rails_env, "production"

# necessary for functioning on the (gs)
default_run_options[:pty] = true

# these shouldn't be changed
role :web, "#{domain}"
role :app, "#{domain}"
role :db,  "#{domain}", :primary => true


after "deploy:update_code".to_sym do
  put File.read("config/database.yml.mt"), "#{release_path}/config/database.yml", :mode => 0444
end

# update .htaccess rules after new version is deployed
# after "deploy:symlink".to_sym, "mt:generate_htaccess".to_sym
