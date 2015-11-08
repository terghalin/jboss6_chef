# Install zip if not present
package "zip"
if platform_family?("rhel", "centos")
  package "unzip"
end

# Initializing MySQL instance
mysql_service 'epam' do
  port node['mysql']['mysql_port']
  version '5.5'
  initial_root_password node['mysql']['mysql_root_pass']
  action [:create, :start]
end

# Downloading guestbookapp.zip to tmp dir
remote_file '/tmp/guestbookapp.zip' do
  source node['application']['application_repo']
  action :create
end

# Importing SQL dump to mysql instance
script "import_sql_dump" do
  interpreter "bash"
  user "root"
  cwd "/tmp"
  code <<-EOH
    unzip -o /tmp/guestbookapp.zip
    mysql -h 127.0.0.1 -u root --password='#{node['mysql']['mysql_root_pass']}' --port=#{node['mysql']['mysql_port']} < /tmp/guestbookapp/guestbookmysqldump.sql
  EOH
end
