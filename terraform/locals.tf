locals {
  all_protocols = "all"

  anywhere = "0.0.0.0/0"

  # port numbers
  ssh_port       = 22
  wireguard_port = 51820
  # http_port      = 80
  # https_port     = 443

  # protocols
  icmp_protocol = 1
  tcp_protocol  = 6
  udp_protocol  = 17
}