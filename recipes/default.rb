#
# Cookbook Name:: sbt-extras
# Recipe:: default
#
# Copyright 2012, Gilles Cornu
#

include_recipe "java"

#group node[:playframework][:group] do
group 'sbt' do
  #members node[:playframework][:users]
  members ['vagrant']
  append true #add new members, if group already exists
end

#directory node[:playframework][:setupdir] do
directory "/opt/sbt-extras/.lib" do
  recursive true
  owner 'root'
  group 'sbt'
  #owner node[:playframework][:owner]
  #group node[:playframework][:group]
  mode '2775' #enable 'setgid' bit to force inheritance of group write permission
end

remote_file "/opt/sbt-extras/sbt" do
  source "https://github.com/paulp/sbt-extras/raw/ea14e4ab0054ffa3f302cf4c93e7e571dc6a84e8/sbt"
  backup false
  mode "0755"
  owner 'root'
  group 'sbt'
  #owner node[:playframework][:owner]
  #group node[:playframework][:group]
  #checksum
  #action :create_if_missing
end

# Symlink to make 'sbt' in the default PATH
link "/usr/bin/sbt" do
  to "/opt/sbt-extras/sbt"
  owner 'root'
  group 'sbt'
end
