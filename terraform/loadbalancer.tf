resource "oci_load_balancer_load_balancer" "k3sserver-lb" {
  #Required
  compartment_id = var.provider_compartment_id
  display_name   = var.k3sserver-ILB_display_name
  # shape          = var.k3sserver-ILB_shape
  shape          = var.k3sserver-ILB_shape
  subnet_ids     = [oci_core_subnet.subnet_k3s-server.id]

  #Optional
  ip_mode                    = var.k3sserver-ILB_ip_mode
  is_private                 = var.k3sserver-ILB_is_private
  network_security_group_ids = [oci_core_network_security_group.k3s-server_nsg.id]

  shape_details {
    #Required
    maximum_bandwidth_in_mbps = var.k3sserver-ILB_shaped_details.maximum_bandwidth_in_mbps
    minimum_bandwidth_in_mbps = var.k3sserver-ILB_shaped_details.minimum_bandwidth_in_mbps
  }
}
