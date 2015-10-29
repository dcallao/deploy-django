#
# Cookbook Name:: deploy-django
# Recipe:: default
#
# Copyright (C) 2015 Daniel Callao
#
# All rights reserved - Do Not Redistribute
#


# Check the node's OS for validation
case node['platform']

when 'ubuntu'

  Chef::Log.info("Platform is a Linux distribution, initiating django sample app deployment")
  # OS Dendencies
  %w(git libpq-dev).each do |pkg|
    package pkg
  end
  # Recipes
  include_recipe 'deploy-django::deploy'
  include_recipe 'deploy-django::customize'
  
when 'centos'
  
  Chef::Log.info("Platform is a Linux distribution, initiating django sample app deployment")
  # OS Dendencies
  %w(git postgresql postgresql-devel python-devel).each do |pkg|
    package pkg
  end
  # Recipes
  include_recipe 'deploy-django::deploy'
  include_recipe 'deploy-django::customize'
  

else

  Chef::Log.warn("Platform #{node['platform']} is not supported at this time.")
  return

end