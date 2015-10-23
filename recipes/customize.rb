#
# Cookbook Name:: deploy-django
# Recipe:: customize
#
# Copyright (C) 2015 Daniel Callao
#
# All rights reserved - Do Not Redistribute
#

# This will install the xrdp package on the box 
package 'xrdp'

# This will enable platform default firewall
firewall 'default' do
  action :install
end

# This will customize ports 80 and 443
firewall_rule 'http/https' do
  protocol :tcp
  port     [80, 443]
  action   :allow
end

firewall_rule 'http/https' do
  protocol :icmp
  port     [80, 443]
  action   :allow
end

# This customizes the TCP wrappers SSH/RDP access
template '/etc/hosts.allow' do
  source 'hosts.allow.erb'
  owner 'root'
  group 'root'
  mode 0644
end

template '/etc/hosts.deny' do
  source 'hosts.deny.erb'
  owner 'root'
  group 'root'
  mode 0644
end

