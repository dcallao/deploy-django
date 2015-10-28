# Attributes for deploying django sample app
default['deploy-django']['sample-app']['source']['git-url'] = 'https://github.com/kirpit/django-sample-app.git'
default['deploy-django']['sample-app']['dest']['dir'] = '/opt/sample-django-app'

# Attributes for the postgres
default['postgresql']['password']['postgres'] = 'postgres'
