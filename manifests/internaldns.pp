## Atomia Internal DNS

### Deploys and configures a dns server which are used for resolving internal dns records

### Variable documentation
#### zone_name: The name of the zone where all servers will be placed (for example atomia.internal)
#### ip_address: The private ip address of the server
#### allow_query: Semi colon separated list of ip ranges allowed to query the dns server, if server is publically reachable this should be changed to contain your ip ranges

### Validations
##### zone_name: .*
##### ip_address(advanced): .*
##### allow_query: .*

class atomia::internaldns (
  $zone_name         = '',
  $ip_address        = $ipaddress,
  $allow_query       = 'any;'
){


  class { 'bind':
    default_view => {
      'recursion' => 'yes',
    },
    config       => {
      'allow-query' => "{ ${allow_query} }",
    }
  }

  bind::zone {$zone_name:
    zone_contact => "contact.${zone_name}",
    zone_ns      => ["ns0.${zone_name}"],
    zone_serial  => '2012112901',
    zone_ttl     => '604800',
    zone_origin  => $zone_name,
  }

  # Set ip correctly when on ec2
  if $::ec2_public_ipv4 {
    $public_ip = $::ec2_public_ipv4
  } elsif $::ipaddress_eth0 {
    $public_ip = $::ipaddress_eth0
  }
  else {
    $public_ip = $::ipaddress
  }

  @@bind::a { 'Hosts in zone':
    ensure    => 'present',
    zone      => $zone_name,
    ptr       => false,
    hash_data => {
      'ns0'    => {
        owner => $public_ip
      },
      'intdns' => {
      owner => $public_ip
      },
    },
  }

  Bind::A <<| |>>
  Bind::Zone <<| |>>

  exec { 'restart_bind':
    command     => '/etc/init.d/bind9 restart',
    refreshonly => true,
  }

}
