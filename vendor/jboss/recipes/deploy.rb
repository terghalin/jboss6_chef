jboss_path = node["jboss"]["path"]
jboss_tmp = node["jboss"]["tmp"]
jboss_user = node["jboss"]["user"]
jboss_app = node["application"]["application_repo"]

remote_file "#{jboss_tmp}/guestbookapp.zip" do
    force_unlink true
    source jboss_app
    owner jboss_user
    group jboss_user
    mode '0755'
    action :create
end

# Extract guestbookapp from archive
execute 'extract_guestbookapp' do
    command "unzip -o -d #{jboss_path}/server/default/deploy/ -j guestbookapp.zip guestbookapp/guestbookapp.war"
    cwd jboss_tmp
    user jboss_user
    group jboss_user
end

# Restart jboss
execute 'restart_jboss' do
command "/etc/init.d/jboss restart"
user 'root'
group 'root'
end
