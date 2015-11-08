
firewall 'default'
# open jboss default 8180 port to tcp traffic
firewall_rule 'http_jboss' do
  port     8080
  protocol :tcp
  position 1
  command   :allow
end

firewall_rule 'ssh' do
  port     22
  protocol :tcp
  position 2
  command   :allow
end
