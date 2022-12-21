resource "oci_core_instance_pool" "IP-k3sserver" {
  compartment_id            = var.provider_compartment_id
  instance_configuration_id = oci_core_instance_configuration.IC-k3sserver.id
  placement_configurations {
    availability_domain = var.IC_ID_LD_availability_domain
    primary_subnet_id   = oci_core_subnet.subnet_k3s-server.id
  }
  size         = var.k3sserver-IP_size
  display_name = var.k3sserver-IP_display_name
  load_balancers {
    backend_set_name = oci_load_balancer_backend_set.k3sserver-ILB-BackendSet.name
    load_balancer_id = oci_load_balancer_load_balancer.k3sserver-ILB.id
    port             = 6443
    vnic_selection   = "PrimaryVnic"
  }
  provisioner "local-exec" {
    command = "echo '${tls_private_key.ssh_key.private_key_openssh}' > oci.privkey"
  }
}