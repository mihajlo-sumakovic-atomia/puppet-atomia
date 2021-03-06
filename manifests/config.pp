## Atomia Basic Configuration

### Holds basic Atomia Configuration

### Variable documentation
#### atomia_domain: The domain name where all your Atomia applications will be placed. For example entering atomia.com will mean that your applications will be accessible at hcp.atomia.com, billing.atomia.com etc. Please make sure that you have a valid wildcard SSL certificate for the domain name you choose as the Atomia frontend applications are served over SSL
#### atomia_admin_password: Password used to log in to Atomia Admin Panel
#### puppet_hostname: The hostname of the Puppet master
#### puppet_ip: The ip address of the Puppet master
#### test_env: Set this to 1 if you are installing a test environment
#### use_cloudlinux: Set this to 1 if you are installing a CloudLinux web cluster

### Validations
##### atomia_domain: %hostname
##### atomia_admin_password(advanced): %password
##### puppet_hostname: %puppet_host
##### puppet_ip: $puppet_ip
##### test_env: %int_boolean
##### use_cloudlinux: %int_boolean

class atomia::config (
  $atomia_domain         = '',
  $atomia_admin_password = 'Administrator',
  $puppet_hostname       = '%puppet_host',
  $puppet_ip             = '%puppet_ip',
  $test_env              = '0',
  $use_cloudlinux        = '0',
){

}
