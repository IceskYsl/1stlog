#
# General configuration
#
set :user, "taojer"
set :ssh_flags,             '-p 22'
set :sudo_cmd, 'sudo'
set :sudo_password, 'taojer321123'
set :application,           '1stlog'
set :domain, '1stlog.1sters.com'
set :deploy_to,             '/home/taojer/webroot/ror/1stlog'
set :repository,            'git@github.com:IceskYsl/1stlog.git'
set :scm,         "git"

#Config web app
set :web, "nginx"
set :nginx_sites_available, "/etc/nginx/sites-available"
set :nginx_sites_enabled, "/etc/nginx/sites-enabled"
set :nginx_command, ' /etc/init.d/nginx'

#
# Mongrel configuration
#
set :mongrel_clean,         false
set :mongrel_command,    'mongrel_rails'
set :mongrel_group,         'taojer'
set :mongrel_port,          9000
set :mongrel_servers,       2
set :mongrel_address,       '127.0.0.1'
set(:mongrel_conf)          { "#{shared_path}/mongrel_cluster.conf" }
set :mongrel_config_script, nil
set :mongrel_environment,   'production'
set :mongrel_log_file,      nil
set :mongrel_pid_file,      nil
set :mongrel_prefix,        nil
set :mongrel_user,          'taojer'

namespace :vlad do
  desc 'Runs vlad:update, vlad:symlink, vlad:migrate and vlad:start'
  task :deploy => ['vlad:update', 'vlad:symlink', 'vlad:migrate', 'vlad:stop_app', 'vlad:start_app']

  desc 'Symlinks your custom directories'
  remote_task :symlink, :roles => :app do
    run "ln -s #{shared_path}/config/database.yml #{current_release}/config/database.yml"
  end
end



