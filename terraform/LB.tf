resource "oci_network_load_balancer_network_load_balancer" "k3sserver-ILB" {
  compartment_id                 = var.provider_compartment_id
  display_name                   = var.k3sserver-ILB_display_name
  subnet_id                      = oci_core_subnet.subnet_k3s-server.id
  is_preserve_source_destination = true
  is_private                     = true
  network_security_group_ids     = [oci_core_network_security_group.k3s-server_nsg.id]
  nlb_ip_version                 = "IPV4"
}

resource "oci_network_load_balancer_network_load_balancer" "k3sagent-ILB" {
  compartment_id                 = var.provider_compartment_id
  display_name                   = var.k3sagent-ILB_display_name
  subnet_id                      = oci_core_subnet.subnet_k3s-agent.id
  is_preserve_source_destination = true
  is_private                     = true
  network_security_group_ids     = [oci_core_network_security_group.k3s-agent_nsg.id]
  nlb_ip_version                 = "IPV4"
}

resource "oci_network_load_balancer_network_load_balancer" "k3sdb-ILB" {
  compartment_id                 = var.provider_compartment_id
  display_name                   = var.k3sdb-ILB_display_name
  subnet_id                      = oci_core_subnet.subnet_k3s-db.id
  is_preserve_source_destination = true
  is_private                     = true
  network_security_group_ids     = [oci_core_network_security_group.k3s-db_nsg.id]
  nlb_ip_version                 = "IPV4"
}

