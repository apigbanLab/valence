# resource "oci_core_instance" "k3s-server-01" {
#   display_name                        = "k3s-server-01"
#   is_pv_encryption_in_transit_enabled = var.vm_is_pv_encryption_in_transit_enabled
#   availability_domain                 = var.vm_availability_domain
#   compartment_id                      = var.provider_compartment_id
#   shape                               = var.vm_server_shape
#   fault_domain                        = "FAULT-DOMAIN-1"
#   metadata = {
#     "ssh_authorized_keys" = tls_private_key.ssh_key.public_key_openssh
#   }
#   launch_options {
#     is_pv_encryption_in_transit_enabled = var.vm_launch_options.is_pv_encryption_in_transit_enabled
#     network_type                        = var.vm_launch_options.network_type
#   }
#   shape_config {
#     memory_in_gbs = var.vm_k3s_server_shape_config.memory_in_gbs
#     ocpus         = var.vm_k3s_server_shape_config.ocpus
#   }
#   create_vnic_details {
#     assign_private_dns_record = "true"
#     assign_public_ip          = "true"
#     subnet_id                 = oci_core_subnet.subnet_k3s-server.id
#     nsg_ids                   = [oci_core_network_security_group.k3s-server_nsg.id]
#   }
#   availability_config {
#     recovery_action = var.vm_availability_config.recovery_action
#   }
#   source_details {
#     source_id   = var.vm_x86_image_source_details.source_id
#     source_type = var.vm_x86_image_source_details.source_type
#   }
#   agent_config {
#     is_management_disabled = "false"
#     is_monitoring_disabled = "false"
#     plugins_config {
#       desired_state = "DISABLED"
#       name          = "Vulnerability Scanning"
#     }
#     plugins_config {
#       desired_state = "ENABLED"
#       name          = "Compute Instance Monitoring"
#     }
#     plugins_config {
#       desired_state = "ENABLED"
#       name          = "Bastion"
#     }
#   }
#   instance_options {
#     are_legacy_imds_endpoints_disabled = var.vm_are_legacy_imds_endpoints_disabled
#   }
# }

# resource "oci_core_instance" "k3s-server-02" {
#   display_name                        = "k3s-server-02"
#   is_pv_encryption_in_transit_enabled = var.vm_is_pv_encryption_in_transit_enabled
#   availability_domain                 = var.vm_availability_domain
#   compartment_id                      = var.provider_compartment_id
#   shape                               = var.vm_server_shape
#   fault_domain                        = "FAULT-DOMAIN-2"
#   metadata = {
#     "ssh_authorized_keys" = tls_private_key.ssh_key.public_key_openssh
#   }
#   launch_options {
#     is_pv_encryption_in_transit_enabled = var.vm_launch_options.is_pv_encryption_in_transit_enabled
#     network_type                        = var.vm_launch_options.network_type
#   }
#   shape_config {
#     memory_in_gbs = var.vm_k3s_server_shape_config.memory_in_gbs
#     ocpus         = var.vm_k3s_server_shape_config.ocpus
#   }
#   create_vnic_details {
#     assign_private_dns_record = "true"
#     assign_public_ip          = "true"
#     subnet_id                 = oci_core_subnet.subnet_k3s-server.id
#     nsg_ids                   = [oci_core_network_security_group.k3s-server_nsg.id]
#   }
#   availability_config {
#     recovery_action = var.vm_availability_config.recovery_action
#   }
#   source_details {
#     source_id   = var.vm_x86_image_source_details.source_id
#     source_type = var.vm_x86_image_source_details.source_type
#   }
#   agent_config {
#     is_management_disabled = "false"
#     is_monitoring_disabled = "false"
#     plugins_config {
#       desired_state = "DISABLED"
#       name          = "Vulnerability Scanning"
#     }
#     plugins_config {
#       desired_state = "ENABLED"
#       name          = "Compute Instance Monitoring"
#     }
#     plugins_config {
#       desired_state = "ENABLED"
#       name          = "Bastion"
#     }
#   }
#   instance_options {
#     are_legacy_imds_endpoints_disabled = var.vm_are_legacy_imds_endpoints_disabled
#   }
# }

# resource "oci_core_instance" "k3s-agent-01" {
#   display_name                        = "k3s-agent-01"
#   is_pv_encryption_in_transit_enabled = var.vm_is_pv_encryption_in_transit_enabled
#   availability_domain                 = var.vm_availability_domain
#   compartment_id                      = var.provider_compartment_id
#   shape                               = var.vm_agent_shape
#   fault_domain                        = "FAULT-DOMAIN-1"
#   metadata = {
#     "ssh_authorized_keys" = tls_private_key.ssh_key.public_key_openssh
#   }
#   launch_options {
#     is_pv_encryption_in_transit_enabled = var.vm_launch_options.is_pv_encryption_in_transit_enabled
#     network_type                        = var.vm_launch_options.network_type
#   }
#   shape_config {
#     memory_in_gbs = var.vm_k3s_agent_shape_config.memory_in_gbs
#     ocpus         = var.vm_k3s_agent_shape_config.ocpus
#   }
#   create_vnic_details {
#     assign_private_dns_record = "true"
#     assign_public_ip          = "true"
#     subnet_id                 = oci_core_subnet.subnet_k3s-agent.id
#     nsg_ids                   = [oci_core_network_security_group.k3s-agent_nsg.id]
#   }
#   availability_config {
#     recovery_action = var.vm_availability_config.recovery_action
#   }
#   source_details {
#     source_id   = var.vm_aarch64_image_source_details.source_id
#     source_type = var.vm_aarch64_image_source_details.source_type
#   }
#   agent_config {
#     is_management_disabled = "false"
#     is_monitoring_disabled = "false"
#     plugins_config {
#       desired_state = "DISABLED"
#       name          = "Vulnerability Scanning"
#     }
#     plugins_config {
#       desired_state = "ENABLED"
#       name          = "Compute Instance Monitoring"
#     }
#     plugins_config {
#       desired_state = "ENABLED"
#       name          = "Bastion"
#     }
#   }
#   instance_options {
#     are_legacy_imds_endpoints_disabled = var.vm_are_legacy_imds_endpoints_disabled
#   }
# }

# resource "oci_core_instance" "k3s-agent-02" {
#   display_name                        = "k3s-agent-02"
#   is_pv_encryption_in_transit_enabled = var.vm_is_pv_encryption_in_transit_enabled
#   availability_domain                 = var.vm_availability_domain
#   compartment_id                      = var.provider_compartment_id
#   shape                               = var.vm_agent_shape
#   fault_domain                        = "FAULT-DOMAIN-2"
#   metadata = {
#     "ssh_authorized_keys" = tls_private_key.ssh_key.public_key_openssh
#   }
#   launch_options {
#     is_pv_encryption_in_transit_enabled = var.vm_launch_options.is_pv_encryption_in_transit_enabled
#     network_type                        = var.vm_launch_options.network_type
#   }
#   shape_config {
#     memory_in_gbs = var.vm_k3s_agent_shape_config.memory_in_gbs
#     ocpus         = var.vm_k3s_agent_shape_config.ocpus
#   }
#   create_vnic_details {
#     assign_private_dns_record = "true"
#     assign_public_ip          = "true"
#     subnet_id                 = oci_core_subnet.subnet_k3s-agent.id
#     nsg_ids                   = [oci_core_network_security_group.k3s-agent_nsg.id]
#   }
#   availability_config {
#     recovery_action = var.vm_availability_config.recovery_action
#   }
#   source_details {
#     source_id   = var.vm_aarch64_image_source_details.source_id
#     source_type = var.vm_aarch64_image_source_details.source_type
#   }
#   agent_config {
#     is_management_disabled = "false"
#     is_monitoring_disabled = "false"
#     plugins_config {
#       desired_state = "DISABLED"
#       name          = "Vulnerability Scanning"
#     }
#     plugins_config {
#       desired_state = "ENABLED"
#       name          = "Compute Instance Monitoring"
#     }
#     plugins_config {
#       desired_state = "ENABLED"
#       name          = "Bastion"
#     }
#   }
#   instance_options {
#     are_legacy_imds_endpoints_disabled = var.vm_are_legacy_imds_endpoints_disabled
#   }
# }

# resource "oci_core_instance" "k3s-db-01" {
#   display_name                        = "k3s-db-01"
#   is_pv_encryption_in_transit_enabled = var.vm_is_pv_encryption_in_transit_enabled
#   availability_domain                 = var.vm_availability_domain
#   compartment_id                      = var.provider_compartment_id
#   shape                               = var.vm_db_shape
#   fault_domain                        = "FAULT-DOMAIN-3"
#   metadata = {
#     "ssh_authorized_keys" = tls_private_key.ssh_key.public_key_openssh
#   }
#   launch_options {
#     is_pv_encryption_in_transit_enabled = var.vm_launch_options.is_pv_encryption_in_transit_enabled
#     network_type                        = var.vm_launch_options.network_type
#   }
#   shape_config {
#     memory_in_gbs = var.vm_k3s_db_shape_config.memory_in_gbs
#     ocpus         = var.vm_k3s_db_shape_config.ocpus
#   }
#   create_vnic_details {
#     assign_private_dns_record = "true"
#     assign_public_ip          = "true"
#     subnet_id                 = oci_core_subnet.subnet_k3s-db.id
#     nsg_ids                   = [oci_core_network_security_group.k3s-db_nsg.id]
#   }
#   availability_config {
#     recovery_action = var.vm_availability_config.recovery_action
#   }
#   source_details {
#     source_id   = var.vm_aarch64_image_source_details.source_id
#     source_type = var.vm_aarch64_image_source_details.source_type
#   }
#   agent_config {
#     is_management_disabled = "false"
#     is_monitoring_disabled = "false"
#     plugins_config {
#       desired_state = "DISABLED"
#       name          = "Vulnerability Scanning"
#     }
#     plugins_config {
#       desired_state = "ENABLED"
#       name          = "Compute Instance Monitoring"
#     }
#     plugins_config {
#       desired_state = "ENABLED"
#       name          = "Bastion"
#     }
#   }
#   instance_options {
#     are_legacy_imds_endpoints_disabled = var.vm_are_legacy_imds_endpoints_disabled
#   }
#   provisioner "local-exec" {
#     command = "echo '${tls_private_key.ssh_key.private_key_openssh}' > oci.privkey"
#   }
# }