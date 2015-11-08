#
# Cookbook Name:: jboss
# Recipe:: setup
#
# Copyright (c) 2015 terghalin, All Rights Reserved.

jboss_url = node["jboss"]["url"]
jboss_path = node["jboss"]["path"]
jboss_tmp = node["jboss"]["tmp"]
jboss_user = node["jboss"]["user"]
jboss_app = node["application"]["application_repo"]
jboss_mysql_con_url = node["jboss"]["mysql_con_url"]
jboss_module_path = node["jboss"]["mysql_modpath"]

# Add ubuntu PPA repository with Oracle java packages
apt_repository 'webupd8team-java' do
  uri          'ppa:webupd8team/java'
  components ['main']
  distribution 'trusty'
  action :add
end

# Install ZIP package
package "zip"
if platform_family?("rhel", "centos")
  package "unzip"
end

# could be improved to run only on update
execute "accept-license" do
  command "echo oracle-java6-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections"
end

package "oracle-java6-installer" do
  action :install
end

package "oracle-java6-set-default" do
  action :install
end

# Now create jboss user
user jboss_user do
  comment 'Jboss user'
end

# Create directory for Jboss instance
directory jboss_path do
  owner jboss_user
  group jboss_user
  mode '0755'
  action :create
end

# Create tmp directory for Jboss
directory jboss_tmp do
  owner jboss_user
  group jboss_user
  mode '0755'
  action :create
end

# Download jboss installation file
remote_file "#{jboss_tmp}/jboss.zip" do
  force_unlink true
  checksum node['jboss']['checksum']
  source jboss_url
  owner jboss_user
  group jboss_user
  mode '0755'
  action :create
end

# Download mysql connector
remote_file "#{jboss_tmp}/mysql-connector.tar.gz" do
  force_unlink true
  source jboss_mysql_con_url
  owner jboss_user
  group jboss_user
  mode '0755'
  action :create
end

# Parse packages name
jbossrel = jboss_url.split('/')[-3]
release_name = jbossrel.slice(0,2).downcase + jbossrel.slice(2..-1)
mysql_connector_name = jboss_mysql_con_url.split('/')[-1].sub!('.tar.gz','')

# Extract jboss from archive to jboss path
execute 'extract_jboss' do
  command "unzip -o -d #{jboss_tmp} jboss.zip"
  cwd jboss_tmp
  user jboss_user
  group jboss_user
end

# Extract mysql connector
execute 'extract_mysql_connector' do
  command "tar -xzvf mysql-connector.tar.gz"
  cwd jboss_tmp
  user jboss_user
  group jboss_user
end

# Move jboss files one directory up
execute 'move_jboss' do
  command "mv -f #{jboss_tmp}/#{release_name}/* #{jboss_path}/"
  not_if { ::File.exists?("#{jboss_path}/server")}
  cwd jboss_path
end

# Move mysql connector to jboss modules
execute 'move_mysql_connector' do
  command "mv #{jboss_tmp}/#{mysql_connector_name}/#{mysql_connector_name}-bin.jar #{jboss_module_path}/"
  creates "#{jboss_module_path}/#{mysql_connector_name}-bin.jar"
end

# Create mysql module config from template
template "#{jboss_path}/server/default/deploy/mysql-ds.xml" do
  source 'mysql-ds.xml.erb'
  owner jboss_user
  group jboss_user
  mode '0644'
  action :create
end
