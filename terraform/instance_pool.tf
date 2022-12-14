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
    backend_set_name = oci_network_load_balancer_backend_set.k3sserver-ILB-BackendSet_HTTPS6443.name
    load_balancer_id = oci_network_load_balancer_network_load_balancer.k3sserver-ILB.id
    port             = var.k3sserver-ILB_Listeners.kubeapiserver.port
    vnic_selection   = "PrimaryVnic"
  }
  provisioner "local-exec" {
    command = "echo '${tls_private_key.ssh_key.private_key_openssh}' > oci.privkey"
  }
  freeform_tags = {
    "role" = var.k3sserver-IP_role
  }
}

resource "oci_core_instance_pool" "IP-k3sagent" {
  compartment_id            = var.provider_compartment_id
  instance_configuration_id = oci_core_instance_configuration.IC-k3sagent.id
  placement_configurations {
    availability_domain = var.IC_ID_LD_availability_domain
    primary_subnet_id   = oci_core_subnet.subnet_k3s-agent.id
  }
  size         = var.k3sagent-IP_size
  display_name = var.k3sagent-IP_display_name
  load_balancers {
    backend_set_name = oci_network_load_balancer_backend_set.k3sagent-ILB-BackendSet_HTTPS6443.name
    load_balancer_id = oci_network_load_balancer_network_load_balancer.k3sagent-ILB.id
    port             = var.k3sagent-ILB_Listeners.kubeapiserver.port
    vnic_selection   = "PrimaryVnic"
  }
  provisioner "local-exec" {
    command = "echo '${tls_private_key.ssh_key.private_key_openssh}' > oci.privkey"
  }
  freeform_tags = {
    "role" = var.k3sagent-IP_role
  }
}

resource "oci_core_instance_pool" "IP-k3sdb" {
  compartment_id            = var.provider_compartment_id
  instance_configuration_id = oci_core_instance_configuration.IC-k3sdb.id
  placement_configurations {
    availability_domain = var.IC_ID_LD_availability_domain
    primary_subnet_id   = oci_core_subnet.subnet_k3s-db.id
  }
  size         = var.k3sdb-IP_size
  display_name = var.k3sdb-IP_display_name
  load_balancers {
    backend_set_name = oci_network_load_balancer_backend_set.k3sdb-ILB-BackendSet_TCP5432.name
    load_balancer_id = oci_network_load_balancer_network_load_balancer.k3sdb-ILB.id
    port             = var.k3sDB-ILB_Listeners.postgresql.port
    vnic_selection   = "PrimaryVnic"
  }
  provisioner "local-exec" {
    command = "echo '${tls_private_key.ssh_key.private_key_openssh}' > oci.privkey"
  }
  freeform_tags = {
    "role" = var.k3sdb-IP_role
  }
}