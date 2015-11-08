jboss_user = node["jboss"]["user"]

# Install init script
template '/etc/init.d/jboss' do
  source 'init.erb'
  owner jboss_user
  group jboss_user
  mode '0754'
  action :create
end

# Start jboss server
execute 'start_jboss' do
  command "/etc/init.d/jboss start"
  user 'root'
  group 'root'
end
