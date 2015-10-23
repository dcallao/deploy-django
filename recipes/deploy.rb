#
# Cookbook Name:: deploy-django
# Recipe:: deploy
#
# Copyright (C) 2015 Daniel Callao
#
# All rights reserved - Do Not Redistribute
#

# This deploys selinux, permissive
include_recipe "selinux::permissive"

# This deploys the dev packages
include_recipe "build-essential"

# Installs some OS packages
[ "git", "python", "python-setuptools", "python-setuptools-devel" ].each do |pack|
  package pack
end

# Installs pip
execute "install-pip" do
  command "easy_install pip"
end

# Creates the user 'django' as a dedicated user to run the sample app
user "django" do
   :create
end

# This will create the directory for the sample app
directory "/opt/sample-django-app" do
    mode "0755"
    owner "django"
    group "django"
end

# Checks out the sample app from git
git "django_git_repo" do
   repository "#{node['deploy-django']['sample-app']['source']['git-url']}"
   destination "#{node['deploy-django']['sample-app']['dest']['dir']}"
   user "django"
end

# This is a LWRP resource from application_python to deploy the sample django app
application "#{node['deploy-django']['sample-app']['dest']['dir']}" do
  virtualenv
  pip_requirements
  django do
    database 'sqlite:///sample_django.db'
    allowed_hosts = ['*']
    migrate true
  end
end

