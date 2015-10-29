## Description

This cookbook deploys a sample django app hosted on https://github.com/kirpit/django-sample-app.

This cookbook also customizes the end node with the following rulesets:
 - Allow traffic over ICMP and TCP ports 80 and 443 from everywhere
 - Only allow SSH/RDP traffic from the following subnets: 10.0.0.0/8, 192.168.0.0/16, 172.0.0.0/8
 - All other traffic should be dropped
 - The django sample app runs under the `django` user

## Supported Platforms

* Ubuntu 12.04
* Ubuntu 14.04
* CentOS 6.6
* Ubuntu 7.1

## Usage

### Deployment

The following requirements are necessary to deploy this cookbook into your environment:

1. You must have the proper authentication keys under `../chef-repo/.chef` directory to authenticate against your chef server
2. You must have ChefDK installed (https://downloads.chef.io/chef-dk/)
3. You must have vagrant installed (https://www.vagrantup.com/downloads.html)
4. You must have network connectibity to your chef server and connectivity from chef server to your infrastructure.

The following steps will deploy this cookbook:

1. Add the SSH key that will authenticate you to your chef server:
`ssh-add /path/to/key.pem`

2. Bootstrap and push this cookbook to your infrastructure node(s). Run the script `join-to-chef-salt.sh`
`sh join-to-chef-salt.sh "${IP}" -N "${HOSTNAME}" -x "${LOGIN_USER}" -i $SSHKEY -r "$RECIPES"`

Example:
`sh join-to-chef-salt.sh "172.16.10.100" -N "samplevm.amazon.ec2" -x "ec2-user" -i mypem.pem -r "deploy-django"`


### Local Development

This cookbook includes a TestKitchen configuration file to enable local convergence and testing of the cis_os_benchmarks cookbook. 
Depending on your circumstances, you may need to create a `.kitchen.local.yml` file with additional configuration to support things like local proxy servers.

A `.kitchen.local.yml` file has been included for test.

To build a local instance of deploy-django on your dev machine:

1. Clone the master branch `git clone https://github.com/dcallao/deploy-django.git`.
2. Switch into the cookbook directory `cd ./deploy-django`.
3. If necessary, create a `.kitchen.local.yml` file to support your current local environment.
4. Execute kitchen converge to build a local instance of deploy-django.
5. Once converged kitchen login to ssh into the local VM instance (ProTip: you also have full sudo access).

## Recipes

### deploy-django::default
This is the default recipe that will validate the OS type then run the deploy and customize recipes.

### deploy-django::deploy
This recipe will run the sample app deployment.

### deploy-django::customize
This recipe will customize the OS according to the rulesets above mentioned.

## Attributes

<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['deploy-django']['sample-app']['source']['git-url']</tt></td>
    <td>String</td>
    <td>Defines the source git URL of the sample app</td>
    <td><tt>https://github.com/kirpit/django-sample-app.git</tt></td>
  </tr>
  <tr>
    <td><tt>['deploy-django']['sample-app']['dest']['dir']</tt></td>
    <td>String</td>
    <td>Defines destination path where the app will be check out to</td>
    <td><tt>/opt/sample-django-app</tt></td>
  </tr>

</table>

## Contributing

1. Fork the repository on Github
2. Create a named feature branch (i.e. add-new-recipe)
3. Write your change
4. Write tests for your change (if applicable)
5. Run the tests, ensuring they all pass
6. Submit a Pull Request

## License and Authors

Author:: Daniel Callao (danielcallao@gmail.com)
