#
# Cookbook Name:: deploy-django
# Recipe:: customize
#
# Copyright (C) 2015 Daniel Callao
#
# All rights reserved - Do Not Redistribute
#

# This will enable platform default firewall
firewall 'default' do
  action :install
end

# This will customize ports 80 and 443
firewall_rule 'http/https' do
  protocol :tcp
  port     [80, 443]
  command  :allow
end

# This will customize ssh and rdp
firewall_rule 'ssh/rdp' do
  protocol   :tcp
  port       [22, 3389]
  source     '10.0.0.0/8'
  direction  :in      
  command    :allow
end

firewall_rule 'ssh/rdp' do
  protocol   :tcp
  port       [22, 3389]
  source     '192.168.0.0/16'
  direction  :in      
  command    :allow
end

firewall_rule 'ssh/rdp' do
  protocol   :tcp
  port       [22, 3389]
  source     '172.0.0.0/8'
  direction  :in      
  command    :allow
end

# This will customize ssh and rdp
firewall_rule 'ssh/rdp' do
  protocol   :tcp
  port       [22, 3389]
  source     '0.0.0.0/0'
  direction  :in      
  command    :deny
end


