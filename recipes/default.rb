#
# Cookbook Name:: sbt-extras
# Recipe:: default
#
# Copyright 2012, Gilles Cornu
#

include_recipe "java"

script_absolute_path = File.join(node['sbt-extras']['setup_dir'], node['sbt-extras']['script_name'])
tmp_dir = File.join(Chef::Config[:file_cache_path], 'setup-sbt-extras')

# Create (or modify) the group of sbt-extras power users (allowed to install new versions of sbt)
group node['sbt-extras']['group'] do
  members node['sbt-extras']['group_new_members']
  append true # add new members, if the group already exists
end

directory File.join(node['sbt-extras']['setup_dir'], '.lib') do
  recursive true
  owner node['sbt-extras']['owner']
  group node['sbt-extras']['group']
  mode '2775' # enable 'setgid' flag to force group ID inheritance on sub-elements
end

# Download sbt-extras script
remote_file script_absolute_path do
  source node['sbt-extras']['download_url']
  backup false
  mode   '0755'
  owner  node['sbt-extras']['owner']
  group  node['sbt-extras']['group']
  #TODO add checksum validation ?
end

# Optionally create a symlink (typically to be part of default PATH, example: /usr/bin/sbt)
link node['sbt-extras']['bin_symlink'] do
  to     script_absolute_path
  owner  node['sbt-extras']['owner']
  group  node['sbt-extras']['group']
  not_if { node['sbt-extras']['bin_symlink'].nil? }
end

directory node['sbt-extras']['config_dir'] do
  owner node['sbt-extras']['owner']
  group node['sbt-extras']['group']
  mode '0755'
end

# Install default config files
template File.join(node['sbt-extras']['config_dir'], node['sbt-extras']['sbtopts_filename'])  do
  source "sbtopts.erb"
  owner  node['sbt-extras']['owner']
  group  node['sbt-extras']['group']
  mode   '0664'
  variables(
    #TODO make it generic... (:arg_x => node['sbt-extras']['sbtopts']['x'], etc)
    :arg_mem => node['sbt-extras']['sbtopts']['mem']
  )
end

template File.join(node['sbt-extras']['config_dir'], node['sbt-extras']['jvmopts_filename']) do
  source "jvmopts.erb"
  owner  node['sbt-extras']['owner']
  group  node['sbt-extras']['group']
  mode   '0664'
  not_if do 
    node['sbt-extras']['jvmopts_filename'].empty?
  end
end

# Start sbt, to force the installation of default versions of sbt and scala
directory tmp_dir do
  # Create a very-temporary folder to store dummy project files, created by '-sbt-create' arg
  mode '0777'
end
execute "Forcing sbt-extras to install its default sbt version" do
  command "#{script_absolute_path} -mem #{node['sbt-extras']['sbtopts']['mem']} -batch -sbt-create help"
  user    node['sbt-extras']['owner']
  group   node['sbt-extras']['group'] 
  umask   '002' # grant write permission to group.
  cwd     tmp_dir
  timeout node['sbt-extras']['preinstall_cmd']['timeout']
  environment ( { 'HOME' => tmp_dir } ) # .sbt/.ivy2 files won't be kept.
  #TODO: idempotence must be implemented, when found a nice way to dynamically get the sbt default version...
end
directory tmp_dir do
  action :delete
  recursive true
end

# Optionally download and pre-install libraries of sbt version-matrix in user own environment
#TODO: offer a multi-user/system-wide setup variant (e.g. .sbt and .ivy2 shared in a uniqe location, for instance /opt/sbt-extras/.sbt|.ivy2) 
if node['sbt-extras']['preinstall_matrix']
  node['sbt-extras']['preinstall_matrix'].keys.each do |sbt_user|
    node['sbt-extras']['preinstall_matrix'][sbt_user].each do |sbt_version|
      directory tmp_dir do
        # Create a very-temporary folder to store dummy project files, created by '-sbt-create' arg
        mode '0777'
      end
      #  
      execute "running sbt-extras as user #{sbt_user} to pre-install libraries of sbt #{sbt_version}" do

        command "#{script_absolute_path} -mem #{node['sbt-extras']['sbtopts']['mem']} -batch '++ #{sbt_version}' -sbt-create"
        user    sbt_user
        group   node['sbt-extras']['group']
        umask   '002'   # grant write permission to group.
        cwd     tmp_dir
        timeout node['sbt-extras']['preinstall_cmd']['timeout']

        # Workaround: chef-execute switch to user, but keep original environment variables (e.g.  HOME=/root)
        environment ( { 'HOME' => File.join(node['sbt-extras']['user_home_basedir'], sbt_user) } ) 
        #TODO: is there an opscode resource to dynamically get the effective user-home path ? 
        
        not_if do 
          File.directory?(File.join(ENV['HOME'], '.sbt', sbt_version))
        end
      end
      directory tmp_dir do
        action :delete
        recursive true
      end
    end
  end
end
