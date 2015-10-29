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

# This imports application_python
include_recipe "poise-python"

# Deploys sqlite
include_recipe "sqlite"


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
  notifies :run, 'execute[rename-project]', :immediately
  notifies :run, 'execute[move-file]', :immediately
end

# Rename the 'projectname' directory
execute 'rename-project' do
  cwd "#{node['deploy-django']['sample-app']['dest']['dir']}"
  command 'mv projectname djangoproject'
  action :nothing
end

# Move requirements file
execute 'move-file' do
  cwd "#{node['deploy-django']['sample-app']['dest']['dir']}"
  command 'mv requirements.txt djangoproject/requirements.txt'
  action :nothing
end

# Adds the project name
template "#{node['deploy-django']['sample-app']['dest']['dir']}/djangoproject/wsgi.py" do
  source "wsgi.py.erb"
end


# This is a LWRP resource from application_python to deploy the sample django app
application "#{node['deploy-django']['sample-app']['dest']['dir']}/djangoproject" do
  virtualenv
  pip_requirements
  django do
    allowed_hosts = ['*']
    database 'sqlite:///test_django.db'
    local_settings_path "#{node['deploy-django']['sample-app']['dest']['dir']}/djangoproject/settings/default.py"
    manage_path "#{node['deploy-django']['sample-app']['dest']['dir']}/djangoproject/manage.py"
    secret_key "%5^p%275b2z0b4*&q-(2s0q1oj98_+^x7+l@s24101hpfw_rqb"
    collectstatic false
    migrate true
    
  end
end




