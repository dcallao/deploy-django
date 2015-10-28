name             'deploy-django'
maintainer       'Daniel Callao'
maintainer_email 'danielcallao@gmail.com'
license          'All rights reserved'
description      'Installs/Configures deploy-django'
long_description 'Installs/Configures deploy-django'
version          '0.1.0'

# Some dependencies
depends 'apt'
depends 'build-essential'
depends 'selinux'
depends 'application_python'
depends 'postgresql', '~> 3.4.0'
depends 'firewall', '~> 2.0'
depends 'database', '~> 4.0.9'


# OS supported
supports 'ubuntu', '>= 12.04'
supports 'centos', '>= 6.6'

# Recipes
recipe 'deploy-django::default', 'Default recipe'
recipe 'deploy-django::deploy', 'Deploys sample django app'
recipe 'deploy-django::customize', 'Customizes OS post deployment'
